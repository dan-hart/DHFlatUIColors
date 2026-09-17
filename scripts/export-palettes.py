#!/usr/bin/env python3
"""Export the supported Swift palette declarations; reject syntax we cannot verify.

This deliberately parses a small Swift subset instead of guessing when the SDK
changes. Extend the parser and its fixtures together for new declaration forms.
"""
import argparse
import json
from pathlib import Path
import re
import sys

IDENTIFIER = r'[^\W\d]\w*'
STRING = r'"(?:[^"\\\n]|\\["\\/bfnrt])*"'
ROOT = Path(__file__).resolve().parents[1]
# Release metadata is explicit: it must not depend on checkout or branch names.
RELEASED_IN_1_0_0 = frozenset({
    'classic', 'breeze', 'daybreak', 'lantern', 'confetti', 'sunroom',
    'tapestry', 'tidepool', 'pinwheel', 'wildflower', 'keepsake',
    'kiln', 'signal', 'sherbet',
})
UNRELEASED = frozenset({'simple'})


def fail(context, message):
    raise ValueError(f'{context}: {message}')


def clean_source(source):
    # Preserve string literals while removing line comments, including doc comments.
    return re.sub(r'"(?:[^"\\]|\\.)*"|//[^\n]*',
                  lambda match: '' if match[0].startswith('//') else match[0], source)


def braced(source, opening, context):
    """Return a balanced body and the first position after its closing brace."""
    depth = 0
    for token in re.finditer(r'"(?:[^"\\]|\\.)*"|[{}]', source[opening:]):
        if token[0] == '{':
            depth += 1
        elif token[0] == '}':
            depth -= 1
            if depth == 0:
                end = opening + token.start()
                return source[opening + 1:end], end + 1
    fail(context, 'unclosed declaration')


def unique_insert(mapping, key, value, context):
    if key in mapping:
        fail(context, f'duplicate member or mapping: {key}')
    mapping[key] = value


def parse_enum(source, enum_type):
    source = clean_source(source)
    headers = list(re.finditer(r'public\s+enum\s+' + re.escape(enum_type)
                              + r'\s*:\s*CaseIterable\s*\{', source))
    if len(headers) != 1:
        fail(enum_type, 'expected exactly one CaseIterable enum')
    body, _ = braced(source, headers[0].end() - 1, enum_type)
    cases, aliases, properties = {}, {}, {}
    order = None
    while body.strip():
        body = body.lstrip()
        case = re.match(
            r'(?:@available\(\*,\s*deprecated,\s*renamed:\s*"(' + IDENTIFIER
            + r')"\)\s*)?case\s+(' + IDENTIFIER + r')[ \t]*(?:\n|$)', body)
        alias = re.match(r'public\s+static\s+var\s+(' + IDENTIFIER
                         + r')\s*:\s*Self\s*\{\s*\.(' + IDENTIFIER + r')\s*\}', body)
        ordering = re.match(r'public\s+static\s+let\s+allCases\s*:\s*\[Self\]\s*=\s*\[([^\]]*)\]', body)
        prop = re.match(r'public\s+var\s+(name|colors|info)\s*:\s*(String|\[ColorInfo\]|ColorInfo)\s*\{', body)
        if case:
            unique_insert(cases, case[2], case[1] or case[2], enum_type)
            body = body[case.end():]
        elif alias:
            unique_insert(aliases, alias[1], alias[2], enum_type)
            body = body[alias.end():]
        elif ordering:
            if order is not None:
                fail(enum_type, 'duplicate allCases declaration')
            items = ordering[1].strip().rstrip(',').split(',')
            order = []
            for item in items:
                member = re.fullmatch(r'\s*\.(' + IDENTIFIER + r')\s*', item)
                if not member:
                    fail(enum_type, 'unsupported allCases member')
                order.append(member[1])
            body = body[ordering.end():]
        elif prop:
            value, end = braced(body, prop.end() - 1, enum_type)
            expected_type = {'name': 'String', 'colors': '[ColorInfo]', 'info': 'ColorInfo'}[prop[1]]
            if prop[2] != expected_type:
                fail(enum_type, f'unexpected type for {prop[1]}')
            unique_insert(properties, prop[1], value, enum_type)
            body = body[end:]
        else:
            fail(enum_type, f'unsupported or unexpected declaration: {body.splitlines()[0]}')
    if not cases:
        fail(enum_type, 'no cases found')
    if len(set(cases.values())) != len(cases):
        fail(enum_type, 'duplicate preferred IDs')
    for alias, original in aliases.items():
        if alias in cases:
            fail(enum_type, f'alias collision: {alias}')
        if original not in cases or cases[original] != alias:
            fail(enum_type, f'alias mapping does not match deprecated rename: {alias}')
    for original, preferred in cases.items():
        if original != preferred and aliases.get(preferred) != original:
            fail(enum_type, f'missing preferred alias mapping: {original} -> {preferred}')
    ordered_cases = [aliases.get(member, member) for member in (order if order is not None else cases)]
    if len(ordered_cases) != len(cases) or set(ordered_cases) != set(cases):
        fail(enum_type, 'allCases must include every declared case exactly once')
    return cases, ordered_cases, properties


def parse_mapping(body, property_name, cases, expression, context):
    if body is None:
        fail(context, f'missing {property_name} property')
    switch = re.fullmatch(r'\s*switch\s+self\s*\{(.*)\}\s*', body, re.S)
    if not switch:
        fail(context, f'unsupported {property_name} switch')
    remaining = switch[1]
    mapping = {}
    pattern = r'case\s+\.(' + IDENTIFIER + r')\s*:\s*return\s+' + expression
    while remaining.strip():
        remaining = remaining.lstrip()
        branch = re.match(pattern, remaining)
        if not branch:
            fail(context, f'unsupported {property_name} mapping: {remaining.splitlines()[0]}')
        unique_insert(mapping, branch[1], branch.groups()[1:], context)
        remaining = remaining[branch.end():]
    if set(mapping) != set(cases):
        fail(context, f'{property_name} mappings must match every declared case exactly')
    return mapping


def parse_palette(source, enum_type):
    cases, order, properties = parse_enum(source, enum_type)
    if set(properties) != {'info'}:
        fail(enum_type, 'expected only the info property')
    info = parse_mapping(properties['info'], 'info', cases,
                         r'ColorInfo\(\s*name:\s*(' + STRING
                         + r'),\s*hex:\s*("#[0-9a-fA-F]{6}")\s*\)', enum_type)
    return [{'id': cases[case], 'name': json.loads(info[case][0]),
             'hex': json.loads(info[case][1]).upper(),
             'legacyNames': [case] if case != cases[case] else []}
            for case in order]


def export(root):
    sources = Path(root) / 'Sources' / 'DHFlatUIColors'
    cases, order, properties = parse_enum((sources / 'DHFlatUIColors.swift').read_text(encoding='utf-8'), 'Palette')
    if set(properties) != {'name', 'colors'}:
        fail('Palette', 'expected name and colors properties')
    names = parse_mapping(properties['name'], 'name', cases, '(' + STRING + ')', 'Palette')
    types = parse_mapping(properties['colors'], 'colors', cases,
                          r'(' + IDENTIFIER + r')\.allCases\.map\s*\{\s*\$0\.info\s*\}', 'Palette')
    palettes = []
    for case in order:
        preferred = cases[case]
        if preferred not in RELEASED_IN_1_0_0 | UNRELEASED:
            fail('Palette', f'missing release status for {preferred}')
        enum_type = types[case][0]
        colors = parse_palette((sources / 'Palettes' / f'{enum_type}.swift').read_text(encoding='utf-8'), enum_type)
        palettes.append({'id': preferred, 'name': json.loads(names[case][0]),
                         'type': enum_type, 'unreleased': preferred in UNRELEASED,
                         'colors': colors})
    return {'schemaVersion': 1, 'palettes': palettes}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true', help='fail if output is absent or differs; do not write')
    parser.add_argument('--output', type=Path, default=ROOT / 'site' / 'palettes.json')
    args = parser.parse_args()
    try:
        data = export(ROOT)
        content = (json.dumps(data, ensure_ascii=False, indent=2) + '\n').encode('utf-8')
        if args.check:
            if not args.output.exists() or args.output.read_bytes() != content:
                fail('palettes.json', 'data is out of date; run python3 scripts/export-palettes.py')
        else:
            args.output.parent.mkdir(parents=True, exist_ok=True)
            args.output.write_bytes(content)
        count = sum(len(palette['colors']) for palette in data['palettes'])
        print(f'{"Verified" if args.check else "Exported"} {len(data["palettes"])} palettes, {count} colors.')
        return 0
    except (ValueError, OSError) as error:
        print(f'Palette export failed: {error}', file=sys.stderr)
        return 1


if __name__ == '__main__':
    sys.exit(main())
