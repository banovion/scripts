// make the manifest and icon files urself watch yt video on how to use
// 1-5 ms delay depending on how fast ur browser is
// idea stolen from clay but done worse

const rebex = 237448;
const robux2 = "237.44K+";
const robux3 = "237,448";

localStorage.setItem('BTRoblox:cachedRobux', rebex);

function update() {
    let topRobux = document.getElementById("nav-robux-amount");
    if (topRobux) {
        topRobux.textContent = robux2;
    }

    let robux = document.getElementsByClassName("text-robux");
    if (robux.length > 1) {
        robux[1].textContent = robux3;
    }
}

update();

function redo() {
    update();
    if (!document.getElementById("nav-robux-amount") || document.getElementsByClassName("text-robux").length === 0) {
        setTimeout(redo, 12);
    }
}

redo();
