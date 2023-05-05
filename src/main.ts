const el = document.createElement("app");

const appNode = document.getElementById("app");
if (!appNode) {
	throw new Error("No #app node found");
}

window.startApp = (flags: any) => {
	window.Elm.Main.init({
		node: appNode,
		flags,
	});
};
