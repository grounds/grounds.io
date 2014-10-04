var client = null,
    ground = null;

function loadGround() {
    // Return if no editor exists on the page
    var $groundEditor = $('#ground_editor');
    if (!$groundEditor[0]) return;

    // Load data
    var editor    = ace.edit('ground_editor'),
        theme     = $groundEditor.data('theme'),
        language  = $groundEditor.data('language'),
        indent    = $groundEditor.data('indent'),
        keyboard  = $groundEditor.data('keyboard'),
        websocket = $groundEditor.data('websocket');

    client = new Client(websocket);
    ground = new Ground(editor, language, theme, indent, keyboard);

    var gui = new GUI(ground, client);
}

function leaveGround() {
    if (client === null) return;

    client.disconnect();
}

$(document).ready(loadGround);
$(document).on('page:load', loadGround);
$(document).on('page:fetch', leaveGround);
