import test from "node:test";
import assert from "node:assert/strict";
import {
  contrast,
  rgb,
  searchColors,
  snippet,
  readSelection,
} from "../model.mjs";

test("contrast uses linear sRGB and exact thresholds", () => {
  assert.equal(contrast("#000000", "#FFFFFF"), 21);
  assert.equal(contrast("#FF6600", "#FF6600"), 1);
  assert.ok(contrast("#FF6600", "#FFFFFF") < 4.5);
  assert.ok(contrast("#FF6600", "#171C1B") >= 4.5);
  assert.deepEqual(rgb("#3498DB"), [52, 152, 219]);
  assert.throws(() => rgb("red"));
});
const color = {
  id: "riverBlue",
  name: "River Blue",
  hex: "#3498DB",
  legacyNames: ["peterRiver"],
  paletteId: "simple",
  paletteName: "Simple",
  paletteType: "SimplePalette",
};
test("search supports names, hex, legacy names and palettes", () => {
  for (const query of ["river blue", "#3498db", "3498DB", "peter", "simple"]) {
    assert.deepEqual(searchColors([color], query), [color]);
  }
  assert.deepEqual(searchColors([color], "not here"), []);
  assert.deepEqual(searchColors([color], "  "), [color]);
});
test("Swift exports use preferred SDK accessors", () => {
  assert.equal(
    snippet(color, "swiftui"),
    "import DHFlatUIColors\n\nlet color = DHFlatUIColors.SimplePalette.riverBlue.info.color",
  );
  assert.ok(snippet(color, "uikit").endsWith(".info.uiColor"));
  assert.ok(snippet(color, "appkit").endsWith(".info.nsColor"));
  assert.equal(snippet(color, "hex"), "#3498DB");
});
test("deep links validate palette, color and export format", () => {
  const palettes = [{ id: "simple", colors: [color] }];
  assert.deepEqual(
    readSelection("#palette=simple&color=riverBlue&format=uikit", palettes),
    { paletteId: "simple", colorId: "riverBlue", format: "uikit" },
  );
  assert.deepEqual(
    readSelection("#palette=unknown&color=unknown&format=script", palettes),
    { paletteId: "simple", colorId: "riverBlue", format: "swiftui" },
  );
});
