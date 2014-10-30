var client = null,
    ground = null;

function loadGround() {
    // Return if no editor exists on the page
    var $groundEditor = $('#ground_editor');
    if (!$groundEditor[0]) return;

    // Load data
    var ground_params = {
        editor:     ace.edit('ground_editor'),
        theme:      $groundEditor.data('theme'),
        language:   $groundEditor.data('language'),
        indent:     $groundEditor.data('indent'),
        keyboard:   $groundEditor.data('keyboard'),
    };
    
    var runnerUrl = $groundEditor.data('runner-url');

    client = new Client(runnerUrl);
    ground = new Ground(ground_params);

    var gui = new GUI(ground, client);
}

function leaveGround() {
    if (client === null) return;

    client.disconnect();
}

$(document).ready(loadGround);
$(document).on('page:load', loadGround);
$(document).on('page:fetch', leaveGround);
