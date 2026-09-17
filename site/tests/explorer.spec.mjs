import { test, expect } from "@playwright/test";

test("loads the real font and every palette without JavaScript errors", async ({
  page,
}) => {
  const errors = [];
  page.on("pageerror", (error) => errors.push(error.message));
  await page.goto("/");
  await expect(page.locator("#workspace")).toBeVisible();
  await expect(page.locator(".swatch")).toHaveCount(9);
  await expect(page.locator("#selected-name")).toHaveText("Alizarin");
  await expect(page.locator(".palette-option")).toHaveCount(16);
  await page.evaluate(() => document.fonts.ready);
  expect(
    await page.evaluate(() =>
      document.fonts.check('16px "Atkinson Hyperlegible"'),
    ),
  ).toBe(true);
  await page.locator('[data-palette="all"]').click();
  await expect(page.locator(".swatch")).toHaveCount(289);
  await expect(page.locator("#color-count")).toHaveText("289 colors");
  expect(errors).toEqual([]);
});

test("search finds legacy names and clears a helpful empty state", async ({
  page,
}) => {
  await page.goto("/");
  await expect(page.locator("#workspace")).toBeVisible();
  await page.keyboard.press("/");
  await expect(page.locator("#search")).toBeFocused();
  await page.locator("#search").fill("peterRiver");
  await expect(page.locator(".swatch")).toHaveCount(1);
  await page.locator(".swatch").click();
  await expect(page.locator("#selected-name")).toHaveText("River Blue");
  await expect(page.locator("#code")).toContainText(
    "ClassicPalette.riverBlue.info.color",
  );
  await page.locator("#search").fill("no matching colors here");
  await expect(page.locator("#empty-state")).toBeVisible();
  await expect(page.locator(".swatch")).toHaveCount(0);
  await page.locator("#clear-search").click();
  await expect(page.locator(".swatch")).toHaveCount(9);
});

test("copies preferred Swift, hex and a durable share URL", async ({
  page,
  context,
}) => {
  await context.grantPermissions(["clipboard-read", "clipboard-write"]);
  await page.goto("/#palette=simple&color=riverBlue&format=swiftui");
  await expect(page.locator("#selected-name")).toHaveText("River Blue");
  await page.locator("#copy-hex").click();
  expect(await page.evaluate(() => navigator.clipboard.readText())).toBe(
    "#3498DB",
  );
  await page.locator("#code-format").selectOption("uikit");
  await page.locator("#copy-code").click();
  expect(await page.evaluate(() => navigator.clipboard.readText())).toContain(
    "SimplePalette.riverBlue.info.uiColor",
  );
  await page.locator('a[href="#installation"]').click();
  await page.locator("#share").click();
  const shared = await page.evaluate(() => navigator.clipboard.readText());
  expect(shared).toContain("palette=simple&color=riverBlue&format=uikit");
  await page.goto(shared);
  await expect(page.locator("#code")).toContainText(
    "SimplePalette.riverBlue.info.uiColor",
  );
  await page.locator("#copy-install").click();
  expect(await page.evaluate(() => navigator.clipboard.readText())).toContain(
    'from: "1.0.0"',
  );
});

test("changes preview appearance, contrast ink and release availability", async ({
  page,
}) => {
  await page.goto("/#palette=simple&color=riverBlue");
  await expect(page.locator("#availability")).toContainText("not yet");
  await page.locator("#preview-dark").click();
  await expect(page.locator("#preview-stage")).toHaveClass(/dark/);
  await page.locator("#white-contrast").click();
  await expect(page.locator("#white-contrast")).toHaveAttribute(
    "aria-pressed",
    "true",
  );
  await expect(page.locator("#selected-swatch")).toHaveCSS(
    "color",
    "rgb(255, 255, 255)",
  );
  await page.locator('[data-palette="breeze"]').click();
  await expect(page.locator(".swatch")).toHaveCount(20);
  await expect(page.locator("#availability")).toContainText(
    "Available in release 1.0.0",
  );
});

for (const width of [320, 390, 768]) {
  test(`all features fit at ${width}px without horizontal overflow`, async ({
    page,
  }) => {
    await page.setViewportSize({ width, height: 844 });
    await page.goto("/");
    await expect(page.locator("#workspace")).toBeVisible();
    expect(
      await page.evaluate(
        () => document.documentElement.scrollWidth <= innerWidth,
      ),
    ).toBe(true);
    await page.locator("#palette-select").selectOption("confetti");
    await expect(page.locator(".swatch")).toHaveCount(20);
    await page.locator(".swatch").nth(5).click();
    await expect(page.locator("#selected-name")).toHaveText(
      "Lián Hóng Lotus Pink",
    );
    await page.locator("#code-format").selectOption("appkit");
    await expect(page.locator("#code")).toContainText(
      "liánHóngLotusPink.info.nsColor",
    );
    expect(
      await page.evaluate(
        () => document.documentElement.scrollWidth <= innerWidth,
      ),
    ).toBe(true);
    if (width <= 650) {
      await page.locator("#back-to-colors").click();
      await expect(page.locator(".swatch[aria-pressed=true]")).toBeFocused();
    }
  });
}

test("handles invalid links and a failed palette request", async ({ page }) => {
  await page.goto("/#palette=missing&color=missing&format=missing");
  await expect(page.locator("#selected-name")).toHaveText("Alizarin");
  await page.route("**/palettes.json", (route) =>
    route.fulfill({ status: 503, body: "Unavailable" }),
  );
  await page.reload();
  await expect(page.locator("#load-state")).toContainText("couldn’t load");
  await expect(page.locator("#load-state button")).toHaveText("Try again");
  await expect(page.locator("#workspace")).toBeHidden();
});

test("copy failures are reported honestly and reduced motion is respected", async ({
  page,
}) => {
  await page.emulateMedia({ reducedMotion: "reduce" });
  await page.addInitScript(() => {
    Object.defineProperty(navigator, "clipboard", {
      value: {
        writeText: async () => {
          throw new Error("Denied");
        },
      },
    });
  });
  await page.goto("/");
  await expect(page.locator("#workspace")).toBeVisible();
  await page.locator("#copy-hex").click();
  await expect(page.locator("#toast")).toContainText("Copy unavailable");
  await expect(page.locator("html")).toHaveCSS("scroll-behavior", "auto");
});

test("narrow keyboard selection moves focus with the inspector", async ({
  page,
}) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.emulateMedia({ reducedMotion: "reduce" });
  await page.goto("/");
  await expect(page.locator("#workspace")).toBeVisible();
  await page.locator(".swatch").nth(1).focus();
  await page.keyboard.press("Enter");
  await expect(page.locator("#back-to-colors")).toBeFocused();
  await expect(page.locator("#selected-name")).toHaveText("Carrot");
  await page.keyboard.press("Enter");
  await expect(page.locator(".swatch").nth(1)).toBeFocused();
});

test("code controls stay reachable on a short desktop with all colors", async ({
  page,
}) => {
  await page.setViewportSize({ width: 1366, height: 700 });
  await page.goto("/");
  await page.locator('[data-palette="all"]').click();
  await expect(page.locator(".swatch")).toHaveCount(289);
  await page.locator("#copy-code").scrollIntoViewIfNeeded();
  const bounds = await page.locator("#copy-code").boundingBox();
  expect(bounds.y).toBeGreaterThanOrEqual(0);
  expect(bounds.y + bounds.height).toBeLessThanOrEqual(700);
  expect(
    await page
      .locator("#inspector")
      .evaluate((el) => el.scrollHeight > el.clientHeight),
  ).toBe(true);
});

test("returning to a later mobile swatch keeps focus visible", async ({
  page,
}) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.emulateMedia({ reducedMotion: "reduce" });
  await page.goto("/");
  await expect(page.locator("#workspace")).toBeVisible();
  await page.locator("#palette-select").selectOption("all");
  const swatch = page.locator(".swatch").last();
  await swatch.focus();
  await page.keyboard.press("Enter");
  await expect(page.locator("#back-to-colors")).toBeFocused();
  await page.keyboard.press("Enter");
  await expect(swatch).toBeFocused();
  const bounds = await swatch.boundingBox();
  expect(bounds.y).toBeGreaterThanOrEqual(0);
  expect(bounds.y + bounds.height).toBeLessThanOrEqual(844);
});
