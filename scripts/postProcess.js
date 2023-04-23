const postcss = require("postcss");
const fs = require("fs");
const path = require("path");
const uglifyjs = require("uglify-js");

const options = {
	compress: {
		passes: 3,
	},
	mangle: {
		toplevel: true,
	},
	output: {
		beautify: false,
		comments: false,
	},
};

/**
 * @type {import("elm-watch/elm-watch-node").Postprocess}
 */
module.exports = async function postprocess({
	code,
	runMode,
	compilationMode,
}) {
	let css = await processCss().catch((err) => {
		console.error("Error processing CSS", err);
		throw err;
	});

	switch (runMode) {
		case "make":
			const distFilePath = path.join(__dirname, "..", "dist", "main.css");
			fs.writeFileSync(distFilePath, css);
			const res = uglifyjs.minify(code, options);
			if (res.error) {
				throw new Error(res.error);
			}
			return res.code;
		case "hot":
			// remove all new lines in css

			// code = code.replace("'{{css}}'", `\`${css}\`);

			css = css.replace(/'/g, "\\'").replace(/`/g, "'").replace(/\$/g, "\\$");

			// Replace the argument passed to `foo` with the CSS content
			code = code.replace("('{{css}}')", `(\`${css}\`)`);
			break;
	}
	switch (compilationMode) {
		case "standard":
		case "debug":
		case "optimize":
			return code;
		default:
			throw new Error("Invalid mode");
	}
};

async function processCss() {
	const filePath = path.join(__dirname, "..", "src", "main.css");
	console.log("Processing CSS", filePath);
	const cssFile = fs.readFileSync(filePath, "utf8");

	console.log("GOT FILE", cssFile);

	const result = await postcss([
		require("tailwindcss"),
		require("autoprefixer"),
	]).process(cssFile, {
		from: "src/main.css",
		to: "dist/main.css",
	});

	return result.css;
}
