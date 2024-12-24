// @ts-check
import { defineConfig } from "astro/config";
import vue from "@astrojs/vue";

import tailwind from "@astrojs/tailwind";

// https://astro.build/config
export default defineConfig({
	// Enable Vue to support Vue components.
	base: "/",
	integrations: [
		vue(),
		tailwind({
			applyBaseStyles: false,
		}),
	],
	trailingSlash: "never",
	build: {
		// 示例：在构建过程中生 成`page.html` 而不是 `page/index.html`。
		format: "file",
	},
});
