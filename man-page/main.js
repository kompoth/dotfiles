function gebi(a) {
    return document.getElementById(a);
}

function date() {
    let options = { day: 'numeric', month: 'numeric', year: 'numeric'};
    let now = new Date();
    gebi("date").innerHTML = now.toLocaleDateString("en-UK", options);
}

function weather(town) {
    fetch("https://wttr.in/" + town + "?0")
        .then(response => response.text())
        .then(text => {
            document.getElementById("weather").innerHTML = text;
        })
}

function main() {
    window.addEventListener("load", () => {
        console.log("page is fully loaded");
        date();
        weather("Izmir");
    });
}

main();
