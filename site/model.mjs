export const formats = ["swiftui", "uikit", "appkit", "hex"];
export function rgb(hex) {
  if (!/^#[0-9a-f]{6}$/i.test(hex))
    throw new Error("Expected a six-digit hex color");
  return [1, 3, 5].map((i) => parseInt(hex.slice(i, i + 2), 16));
}
function luminance(hex) {
  const values = rgb(hex).map((n) => {
    const s = n / 255;
    return s <= 0.04045 ? s / 12.92 : ((s + 0.055) / 1.055) ** 2.4;
  });
  return values[0] * 0.2126 + values[1] * 0.7152 + values[2] * 0.0722;
}
export function contrast(a, b) {
  const first = luminance(a),
    second = luminance(b);
  return (Math.max(first, second) + 0.05) / (Math.min(first, second) + 0.05);
}
const normalize = (value) =>
  value
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase();
export function searchColors(colors, query) {
  const terms = normalize(query.trim()).split(/\s+/);
  return colors.filter((color) => {
    const text = normalize(
      [
        color.name,
        color.id,
        color.hex,
        color.paletteName,
        ...(color.legacyNames || []),
      ].join(" "),
    );
    return terms.every((term) => text.includes(term));
  });
}
export function snippet(color, format) {
  if (format === "hex") return color.hex;
  const property =
    { swiftui: "color", uikit: "uiColor", appkit: "nsColor" }[format] ||
    "color";
  return `import DHFlatUIColors\n\nlet color = DHFlatUIColors.${color.paletteType}.${color.id}.info.${property}`;
}
export function readSelection(hash, palettes) {
  const params = new URLSearchParams(hash.replace(/^#/, ""));
  const palette =
    palettes.find((p) => p.id === params.get("palette")) ||
    palettes.find((p) => p.id === "simple") ||
    palettes[0];
  const color =
    palette.colors.find((c) => c.id === params.get("color")) ||
    palette.colors[0];
  return {
    paletteId: palette.id,
    colorId: color.id,
    format: formats.includes(params.get("format"))
      ? params.get("format")
      : "swiftui",
  };
}
export function flatten(palettes) {
  return palettes.flatMap((p) =>
    p.colors.map((color) => ({
      ...color,
      paletteId: p.id,
      paletteName: p.name,
      paletteType: p.type,
      unreleased: p.unreleased,
    })),
  );
}
