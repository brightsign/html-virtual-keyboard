/**
 *
 * Created by jsinai on 12/21/15.
 */
var upper:boolean = false;

try {
    var vk = new BSVirtualKeyboard();
    console.log('Successfully constructed BSVirtualKeyboard');
}
catch (err) {
    console.log('Error constructing BSVirtualKeyboard: ' + err);
}
function SendKey(key) {
    if (key == 'cancel') {
        console.log("Hiding");
        vk.Hide();
        return;
    }
    var toSend = key;
    if (upper) {
        toSend = key.toUpperCase();
    }
    console.log("Sending key " + toSend);
    vk.SendKey(toSend);
}
function toggleCase() {
    upper = !upper;
    console.log("upper = " + upper);
}

function onPageLoad() {
    document.body.addEventListener("click", function (event) {
        console.log("prevented click");
        event.preventDefault();
    });
}
