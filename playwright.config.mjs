import { defineConfig } from "@playwright/test";

export default defineConfig({
  testDir: "./site/tests",
  testMatch: "**/*.spec.mjs",
  fullyParallel: true,
  workers: 2,
  retries: process.env.CI ? 1 : 0,
  reporter: "list",
  use: {
    baseURL: "http://127.0.0.1:8769",
    browserName: "chromium",
    channel: process.env.CI ? undefined : "chrome",
    viewport: { width: 1440, height: 1000 },
    trace: "retain-on-failure",
  },
  webServer: {
    command: "python3 -m http.server 8769 --bind 127.0.0.1 --directory site",
    url: "http://127.0.0.1:8769",
    reuseExistingServer: !process.env.CI,
  },
});
