# Rust Elm

Production ready web apps with Elm, Rust, and TailwindCSS.

## Prerequisites

Ensure that you have the following dependencies installed locally.

- [rust](https://www.rust-lang.org/tools/install)
- [elm](https://elm-lang.org/)
- [node](https://nodejs.org/en)
- [elm-watch](https://lydell.github.io/elm-watch/)

## Setup

- cargo check
- npm install

## Dev Mode

```bash
npm run dev
```

This will run `cargo run --features dev` and `elm-watch hot`.

Elm changes will hot reload, and changes to your Rust code you will need to kill the process with `ctrl+c` and re-run `npm run dev`.


## Prod Mode

```bash
npm run build
```

```bash
npm start
```

## Differences in Production and Development Mode

This setup strives to run development mode as close as possible to how our production app will run. The primary difference between production and development modes is in how we load the TailwindCSS generated files to the browser.

In production mode, we simply use a link tag in the HTML document and let the browser do what it does best. For development mode, we inject the css directly into the generated JS bundle. This ensures that whenever we change the Elm code, the new generated CSS code is hot reloaded at the same time as the Elm code. This prevents some screen flickering that can be seen when the Elm code and CSS file are not updated in the browser at the exact same time.
