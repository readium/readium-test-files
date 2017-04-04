/**
 * Created by rkwright on 4/4/17.
 */
function changeButton() {
    document.querySelector('button').style.backgroundColor = "green";
    document.querySelector('button').innerHTML = "Works!";
}

function clickHandler(e) {
    setTimeout(changeButton, 1000);
}

function onload() {
    // Initialization work goes here.
}

// Add event listeners once the DOM has fully loaded by listening for the
// `DOMContentLoaded` event on the document, and adding your listeners to
// specific elements when it triggers.
document.addEventListener('DOMContentLoaded', function () {
    document.querySelector('button').addEventListener('click', clickHandler);
    onload();
});