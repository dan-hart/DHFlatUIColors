import {
  contrast,
  rgb,
  searchColors,
  snippet,
  readSelection,
  flatten,
} from "./model.mjs";

const $ = (id) => document.getElementById(id);
const ink = { white: "#FFFFFF", dark: "#171C1B" };
let palettes = [],
  records = [],
  selected,
  activePalette = "simple",
  format = "swiftui",
  textInk = "dark",
  toastTimer;
const descriptions = {
  simple: [
    "LESS, BUT JUST ENOUGH",
    "Nine favorites. A small, considered collection for when you don’t need the whole spectrum.",
  ],
  classic: [
    "WHERE IT ALL STARTED",
    "The original collection. Familiar colors with room for something new.",
  ],
  breeze: [
    "A BREATH OF FRESH COLOR",
    "Airy mint, soft lavender, and a little warmth. An easy place to start.",
  ],
  daybreak: [
    "A BRIGHTER BEGINNING",
    "Warm yellows and peach meet cool blues and deep violet.",
  ],
  lantern: [
    "A LITTLE LIGHT",
    "Bright accents with navy and slate to keep things grounded.",
  ],
  confetti: [
    "SMALL MOMENTS OF JOY",
    "Pink, cyan, orange, and purple. A playful collection with plenty of range.",
  ],
  sunroom: [
    "LET THE LIGHT IN",
    "Fresh greens, warm coral, clear blues, and light neutrals.",
  ],
  tapestry: [
    "COLOR, WOVEN TOGETHER",
    "Rich jewel tones from end to end, with very few neutrals.",
  ],
  tidepool: [
    "LOOK A LITTLE CLOSER",
    "Layers of blue and sea green, punctuated by warm orange.",
  ],
  pinwheel: [
    "A TURN FOR THE COLORFUL",
    "A balanced spread of lively, clear colors across the spectrum.",
  ],
  wildflower: [
    "A LITTLE ROOM TO GROW",
    "Lavender, berry, peach, and mint, with softer greens between.",
  ],
  keepsake: [
    "SOMETHING TO COME BACK TO",
    "Dusty rose, softened peach, cornflower, and muted purple.",
  ],
  kiln: [
    "WARMTH WITH CHARACTER",
    "Clay orange, ochre, stone, and cream alongside deep, glazed blues.",
  ],
  signal: [
    "CLEAR AND BRIGHT",
    "Crisp, vivid colors with a little charcoal for balance.",
  ],
  sherbet: [
    "A SCOOP OF COLOR",
    "Lemon, pink, lilac, and icy mint. Bright without taking itself too seriously.",
  ],
};

function notify(message) {
  clearTimeout(toastTimer);
  $("toast").textContent = message;
  $("toast").classList.add("visible");
  toastTimer = setTimeout(() => $("toast").classList.remove("visible"), 3000);
}
async function copy(value, label) {
  try {
    if (navigator.clipboard?.writeText) {
      await navigator.clipboard.writeText(value);
    } else {
      const input = document.createElement("textarea");
      input.value = value;
      input.style.position = "fixed";
      input.style.opacity = "0";
      document.body.append(input);
      input.select();
      let success;
      try {
        success = document.execCommand("copy");
      } finally {
        input.remove();
      }
      if (!success) throw new Error("Copy unavailable");
    }
    notify(`${label} copied.`);
  } catch {
    notify("Copy unavailable. Select the value or code and copy it manually.");
  }
}
function syncURL() {
  if (!selected) return;
  const params = new URLSearchParams({
    palette: selected.paletteId,
    color: selected.id,
    format,
  });
  history.replaceState(
    null,
    "",
    `${location.pathname}${location.search}#${params}`,
  );
}
function chooseColor(color, { announce = false } = {}) {
  selected = color;
  textInk =
    contrast(color.hex, ink.dark) >= contrast(color.hex, ink.white)
      ? "dark"
      : "white";
  renderInspector();
  document
    .querySelectorAll(".swatch")
    .forEach((button) =>
      button.setAttribute(
        "aria-pressed",
        String(button.dataset.key === `${color.paletteId}/${color.id}`),
      ),
    );
  syncURL();
  if (announce) {
    notify(`${color.name} selected. Preview and code updated.`);
    if (matchMedia("(max-width: 650px)").matches) {
      $("inspector").scrollIntoView({
        behavior: matchMedia("(prefers-reduced-motion: reduce)").matches
          ? "instant"
          : "smooth",
        block: "start",
      });
      $("back-to-colors").focus({ preventScroll: true });
    }
  }
}
function setPreviewInk(value) {
  textInk = value;
  $("inspector").style.setProperty("--preview-ink", ink[value]);
  $("white-contrast").setAttribute("aria-pressed", String(value === "white"));
  $("dark-contrast").setAttribute("aria-pressed", String(value === "dark"));
}
function renderInspector() {
  if (!selected) return;
  $("inspector").style.setProperty("--selected", selected.hex);
  setPreviewInk(textInk);
  $("selected-name").textContent = selected.name;
  $("selected-palette").textContent = `${selected.paletteName} palette`;
  $("selected-hex").textContent = selected.hex;
  $("copy-hex").setAttribute("aria-label", `Copy ${selected.hex}`);
  $("selected-rgb").textContent = `RGB  ${rgb(selected.hex).join(" / ")}`;
  for (const key of ["white", "dark"]) {
    const ratio = contrast(selected.hex, ink[key]);
    $(`${key}-ratio`).textContent = `${ratio.toFixed(2)}:1`;
    $(`${key}-rating`).textContent =
      ratio >= 4.5
        ? "AA normal ✓"
        : ratio >= 3
          ? "Large text only"
          : "Low contrast";
    $(`${key}-contrast`).setAttribute(
      "aria-label",
      `${key === "white" ? "White" : "Dark"} text: ${ratio.toFixed(2)} to 1, ${$(`${key}-rating`).textContent}`,
    );
  }
  $("code-format").value = format;
  $("code").textContent = snippet(selected, format);
  $("code-label").textContent = format === "hex" ? "HEX VALUE" : "SWIFT";
  $("availability").textContent = selected.unreleased
    ? "On main · Simple is not yet in release 1.0.0."
    : "Available in release 1.0.0 · Preferred SDK name.";
  $("availability").classList.toggle("unreleased", selected.unreleased);
}
function selectPalette(id) {
  activePalette = id;
  $("search").value = "";
  if (id !== "all") chooseColor(records.find((c) => c.paletteId === id));
  renderCollection();
}
function renderNavigation() {
  const nav = $("palette-nav"),
    options = $("palette-select");
  nav.replaceChildren();
  options.replaceChildren();
  const navItems = [
    { id: "all", name: "All colors", colors: records },
    ...palettes,
  ];
  // Simple is the small starting palette; SDK order remains unchanged in the exported data.
  const simple = navItems.findIndex((p) => p.id === "simple");
  if (simple > 1) navItems.splice(1, 0, navItems.splice(simple, 1)[0]);
  for (const palette of navItems) {
    const button = document.createElement("button");
    button.className = `palette-option${palette.id === "all" ? " all-option" : ""}`;
    button.dataset.palette = palette.id;
    const dot = document.createElement("span");
    dot.className = "palette-marker";
    dot.setAttribute("aria-hidden", "true");
    if (palette.id !== "all")
      dot.style.background =
        palette.colors[Math.min(2, palette.colors.length - 1)].hex;
    const name = document.createElement("span");
    name.textContent = palette.name;
    const count = document.createElement("span");
    count.className = "palette-count";
    count.textContent = palette.colors.length;
    button.append(dot, name, count);
    button.addEventListener("click", () => selectPalette(palette.id));
    nav.append(button);
    if (palette.id === "all") {
      const line = document.createElement("hr");
      line.className = "palette-divider";
      nav.append(line);
    }
    const option = document.createElement("option");
    option.value = palette.id;
    option.textContent = `${palette.name} · ${palette.colors.length}`;
    options.append(option);
  }
  $("palette-total").textContent = palettes.length;
}
function renderCollection() {
  const query = $("search").value.trim();
  const palette = palettes.find((p) => p.id === activePalette);
  const results = query
    ? searchColors(records, query)
    : activePalette === "all"
      ? records
      : records.filter((c) => c.paletteId === activePalette);
  const title = query
    ? "Search results"
    : activePalette === "all"
      ? "The whole spectrum"
      : palette.name;
  $("collection-title").replaceChildren(document.createTextNode(title));
  const dot = document.createElement("span");
  dot.className = "title-dot";
  dot.textContent = ".";
  $("collection-title").append(dot);
  $("collection-kicker").textContent = query
    ? "FIND SOMETHING GOOD"
    : activePalette === "all"
      ? "EVERY COLOR, EVERY POSSIBILITY"
      : descriptions[activePalette]?.[0] || "EXPLORE THE COLLECTION";
  $("collection-description").textContent = query
    ? `Matching “${query}” across every palette, including previous color names.`
    : activePalette === "all"
      ? `All ${records.length} color entries from the SDK, including the nine-color Simple collection. Repeated hex values belong to different palettes.`
      : descriptions[activePalette]?.[1] ||
        `${palette.colors.length} colors, ready to use in your next project.`;
  $("color-count").textContent =
    `${results.length} ${results.length === 1 ? "color" : "colors"}`;
  document
    .querySelectorAll(".palette-option")
    .forEach((b) =>
      b.setAttribute(
        "aria-current",
        String(!query && b.dataset.palette === activePalette),
      ),
    );
  $("palette-select").value = query ? "all" : activePalette;
  const grid = $("swatch-grid");
  grid.replaceChildren();
  $("empty-state").hidden = results.length > 0;
  const fragment = document.createDocumentFragment();
  results.forEach((color, index) => {
    const button = document.createElement("button");
    button.className = "swatch";
    button.dataset.key = `${color.paletteId}/${color.id}`;
    button.setAttribute(
      "aria-label",
      `${color.name}, ${color.hex}, ${color.paletteName} palette`,
    );
    button.setAttribute(
      "aria-pressed",
      String(
        selected?.paletteId === color.paletteId && selected?.id === color.id,
      ),
    );
    const paint = document.createElement("span");
    paint.className = "swatch-paint";
    paint.style.background = color.hex;
    paint.style.color =
      contrast(color.hex, "#000000") >= contrast(color.hex, ink.white)
        ? "#000000"
        : ink.white;
    const number = document.createElement("span");
    number.className = "swatch-number";
    number.textContent = String(index + 1).padStart(2, "0");
    number.setAttribute("aria-hidden", "true");
    const check = document.createElement("span");
    check.className = "swatch-check";
    check.textContent = "✓";
    check.setAttribute("aria-hidden", "true");
    paint.append(number, check);
    const name = document.createElement("span");
    name.className = "swatch-name";
    name.textContent = color.name;
    const hex = document.createElement("span");
    hex.className = "swatch-hex";
    hex.textContent = color.hex;
    button.append(paint, name, hex);
    if (query || activePalette === "all") {
      const origin = document.createElement("span");
      origin.className = "swatch-origin";
      origin.textContent = color.paletteName;
      button.append(origin);
    }
    button.addEventListener("click", () =>
      chooseColor(color, { announce: true }),
    );
    fragment.append(button);
  });
  grid.append(fragment);
}
function bindEvents() {
  $("search").addEventListener("input", renderCollection);
  $("clear-search").addEventListener("click", () => {
    $("search").value = "";
    renderCollection();
    $("search").focus();
  });
  $("palette-select").addEventListener("change", (event) =>
    selectPalette(event.target.value),
  );
  $("back-to-colors").addEventListener("click", () => {
    const swatch = document.querySelector(".swatch[aria-pressed=true]");
    (swatch || $("swatch-grid")).scrollIntoView({ block: "center" });
    swatch?.focus({ preventScroll: true });
  });
  $("copy-hex").addEventListener("click", () =>
    copy(selected.hex, "Hex value"),
  );
  $("copy-code").addEventListener("click", () =>
    copy(
      snippet(selected, format),
      format === "hex" ? "Hex value" : "Swift code",
    ),
  );
  $("copy-install").addEventListener("click", () =>
    copy($("install-code").textContent, "Package dependency"),
  );
  $("share").addEventListener("click", () => {
    syncURL();
    copy(location.href, "Color link");
  });
  $("code-format").addEventListener("change", (event) => {
    format = event.target.value;
    renderInspector();
    syncURL();
  });
  $("white-contrast").addEventListener("click", () => setPreviewInk("white"));
  $("dark-contrast").addEventListener("click", () => setPreviewInk("dark"));
  for (const appearance of ["light", "dark"]) {
    $(`preview-${appearance}`).addEventListener("click", () => {
      $("preview-stage").classList.toggle("dark", appearance === "dark");
      $("preview-light").setAttribute(
        "aria-pressed",
        String(appearance === "light"),
      );
      $("preview-dark").setAttribute(
        "aria-pressed",
        String(appearance === "dark"),
      );
    });
  }
  document.addEventListener("keydown", (event) => {
    if (
      event.key === "/" &&
      !event.metaKey &&
      !event.ctrlKey &&
      !event.altKey &&
      !["INPUT", "TEXTAREA", "SELECT"].includes(document.activeElement.tagName)
    ) {
      event.preventDefault();
      $("search").focus();
    }
    if (event.key === "Escape" && document.activeElement === $("search")) {
      $("search").value = "";
      renderCollection();
      $("search").blur();
    }
  });
  window.addEventListener("hashchange", () => {
    if (!location.hash.startsWith("#palette=")) return;
    const state = readSelection(location.hash, palettes);
    activePalette = state.paletteId;
    format = state.format;
    $("search").value = "";
    chooseColor(
      records.find(
        (c) => c.paletteId === state.paletteId && c.id === state.colorId,
      ),
    );
    renderCollection();
  });
}
async function start() {
  try {
    const response = await fetch("./palettes.json");
    if (!response.ok) throw new Error("Unable to load palettes");
    const data = await response.json();
    if (
      data.schemaVersion !== 1 ||
      !Array.isArray(data.palettes) ||
      !data.palettes.length
    )
      throw new Error("Invalid palette data");
    palettes = data.palettes;
    records = flatten(palettes);
    const state = readSelection(location.hash, palettes);
    activePalette = state.paletteId;
    format = state.format;
    renderNavigation();
    chooseColor(
      records.find(
        (c) => c.paletteId === state.paletteId && c.id === state.colorId,
      ),
    );
    renderCollection();
    bindEvents();
    $("load-state").hidden = true;
    $("workspace").hidden = false;
    $("explorer").setAttribute("aria-busy", "false");
  } catch (error) {
    console.error("Palette explorer could not start:", error);
    $("load-state").textContent =
      "The colors couldn’t load. Please check your connection and try again.";
    const retry = document.createElement("button");
    retry.textContent = "Try again";
    retry.addEventListener("click", () => location.reload());
    $("load-state").append(retry);
    $("explorer").setAttribute("aria-busy", "false");
  }
}
start();
