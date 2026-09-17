"""Regression tests for the Swift source to explorer data contract."""
import importlib.util
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "export-palettes.py"
FIXTURE = '''
extension DHFlatUIColors {
    public enum ExamplePalette: CaseIterable {
        @available(*, deprecated, renamed: "riverBlue")
        case peterRiver
        case liánHóngLotusPink
        public static var riverBlue: Self { .peterRiver }
        public static let allCases: [Self] = [.liánHóngLotusPink, .riverBlue]
        public var info: ColorInfo {
            switch self {
            case .peterRiver:
                return ColorInfo(name: "River Blue", hex: "#3498DB")
            case .liánHóngLotusPink:
                return ColorInfo(name: "Lián Hóng Lotus Pink", hex: "#F368E0")
            }
        }
    }
}
'''


class ExportTests(unittest.TestCase):
    def setUp(self):
        self.assertTrue(SCRIPT.exists(), "palette exporter must be implemented")
        spec = importlib.util.spec_from_file_location("export_palettes", SCRIPT)
        self.exporter = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(self.exporter)

    def test_preferred_alias_unicode_and_explicit_order(self):
        self.assertEqual(self.exporter.parse_palette(FIXTURE, "ExamplePalette"), [
            {"id": "liánHóngLotusPink", "name": "Lián Hóng Lotus Pink",
             "hex": "#F368E0", "legacyNames": []},
            {"id": "riverBlue", "name": "River Blue",
             "hex": "#3498DB", "legacyNames": ["peterRiver"]},
        ])

    def test_synthesized_all_cases_uses_declaration_order(self):
        source = FIXTURE.replace(
            'public static let allCases: [Self] = [.liánHóngLotusPink, .riverBlue]', '')
        self.assertEqual([c['id'] for c in self.exporter.parse_palette(source, 'ExamplePalette')],
                         ['riverBlue', 'liánHóngLotusPink'])

    def test_missing_alias_fails(self):
        source = FIXTURE.replace('public static var riverBlue: Self { .peterRiver }', '')
        with self.assertRaisesRegex(ValueError, 'alias|mapping'):
            self.exporter.parse_palette(source, 'ExamplePalette')

    def test_missing_info_fails(self):
        source = FIXTURE.replace('case .peterRiver:\n                return ColorInfo(name: "River Blue", hex: "#3498DB")', '')
        with self.assertRaisesRegex(ValueError, 'info|mapping'):
            self.exporter.parse_palette(source, 'ExamplePalette')

    def test_duplicate_preferred_id_fails(self):
        source = FIXTURE.replace('case liánHóngLotusPink', 'case riverBlue')
        with self.assertRaisesRegex(ValueError, 'duplicate|collision'):
            self.exporter.parse_palette(source, 'ExamplePalette')

    def test_all_cases_cannot_omit_or_repeat_a_color(self):
        for order in ['[.riverBlue]', '[.riverBlue, .riverBlue]']:
            with self.subTest(order=order), self.assertRaises(ValueError):
                self.exporter.parse_palette(FIXTURE.replace(
                    '[.liánHóngLotusPink, .riverBlue]', order), 'ExamplePalette')

    def test_unexpected_case_syntax_fails(self):
        source = FIXTURE.replace('case liánHóngLotusPink', 'case liánHóngLotusPink, anotherColor')
        with self.assertRaisesRegex(ValueError, 'unsupported|unexpected'):
            self.exporter.parse_palette(source, 'ExamplePalette')

    def test_missing_palette_type_mapping_fails(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            sources = root / 'Sources' / 'DHFlatUIColors'
            sources.mkdir(parents=True)
            registry = (ROOT / 'Sources/DHFlatUIColors/DHFlatUIColors.swift').read_text()
            registry = registry.replace('case .flatUiV1:\n                return ClassicPalette.allCases.map { $0.info }', '')
            (sources / 'DHFlatUIColors.swift').write_text(registry)
            with self.assertRaisesRegex(ValueError, 'colors|mapping'):
                self.exporter.export(root)

    def test_actual_source_counts_order_and_preferred_members(self):
        data = self.exporter.export(ROOT)
        self.assertEqual(data['schemaVersion'], 1)
        palettes = data['palettes']
        self.assertEqual([p['id'] for p in palettes], [
            'classic', 'breeze', 'daybreak', 'lantern', 'confetti', 'sunroom',
            'tapestry', 'tidepool', 'pinwheel', 'wildflower', 'keepsake',
            'kiln', 'signal', 'sherbet', 'simple'])
        self.assertEqual(sum(len(p['colors']) for p in palettes), 289)
        self.assertEqual([p['id'] for p in palettes if p['unreleased']], ['simple'])
        classic = palettes[0]
        self.assertEqual((classic['name'], classic['type']), ('Classic', 'ClassicPalette'))
        self.assertEqual(classic['colors'][2]['id'], 'riverBlue')
        self.assertEqual(classic['colors'][2]['legacyNames'], ['peterRiver'])
        self.assertEqual(classic['colors'][7]['id'], 'deepWater')
        self.assertEqual(len(palettes[-1]['colors']), 9)
        self.assertIn('liánHóngLotusPink', [c['id'] for c in palettes[4]['colors']])

    def test_check_detects_stale_output_without_overwriting(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / 'palettes.json'
            base = [sys.executable, str(SCRIPT), '--output', str(output)]
            generated = subprocess.run(base, capture_output=True, text=True)
            self.assertEqual(generated.returncode, 0, generated.stderr)
            original = output.read_bytes()
            checked = subprocess.run(base + ['--check'], capture_output=True, text=True)
            self.assertEqual(checked.returncode, 0, checked.stderr)
            output.write_text('{}\n')
            stale = subprocess.run(base + ['--check'], capture_output=True, text=True)
            self.assertNotEqual(stale.returncode, 0)
            self.assertEqual(output.read_text(), '{}\n')
            self.assertNotIn(str(ROOT).encode(), original)


if __name__ == '__main__':
    unittest.main()
