var client = null;
var ground = null;

var loadGround = function() {
  // Return if there is no editor on the page
  var $groundEditor = $("#ground_editor");
  if (!$groundEditor[0]) {
    return;
  }
  // Load data
  var editor = ace.edit("ground_editor");
  var theme = $groundEditor.data("theme");
  var language = $groundEditor.data("language");
  var indent = $groundEditor.data("indent");
  var keyboard = $groundEditor.data("keyboard");
  var websocket = $groundEditor.data("websocket");

  client = new Client(websocket);
  ground = new Ground(editor, language, theme, indent, keyboard);

  var gui = new GUI(ground, client);
};

function leaveGround() {
    if (client === null) return;

    client.disconnect();
}

$(document).ready(loadGround);
$(document).on("page:load", loadGround);
$(document).on("page:fetch", leaveGround);
