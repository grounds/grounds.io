function Ground(params) {
    this.editor = ace.edit(params.id);
    this.session = this.editor.getSession();
    this.commands = this.editor.commands;

    this.session.setUseWorker(false);
    this.setLanguage(params.language, !params.shared);
    this.setTheme(params.theme);
    this.setIndent(params.indent);
    this.setKeyboard(params.keyboard);
}

Ground.prototype.focus = function() {
    this.editor.focus();
};

Ground.prototype.getCode = function () {
    return this.editor.getValue();
};

Ground.prototype.getLanguage = function () {
    return this.language;
};

Ground.prototype.getAttributes = function () {
    return { language: this.getLanguage(), code: this.getCode() };
};

Ground.prototype.setCursor = function (cursor) {
    var lastLine = this.session.getLength();

    this.editor.gotoLine(lastLine);
    this.editor.focus();
};

Ground.prototype.setCode = function (code) {
    this.editor.setValue(code);
};

Ground.prototype.setLanguage = function (language, useSample) {
    this.language = language;
    this.session.setMode('ace/mode/' + utils.getMode(language));

    if (useSample) this.setCode(utils.getSample(language));

    this.setCursor();
};

Ground.prototype.setTheme = function (theme) {
    this.editor.setTheme('ace/theme/' + theme);
};

Ground.prototype.setIndent = function (indent) {
    var useSoftTab = indent !== 'tab';

    if (!useSoftTab) indent = 8;

    this.session.setUseSoftTabs(useSoftTab);
    this.session.setTabSize(indent);
};

Ground.prototype.setKeyboard = function (keyboard) {
    var handler = keyboard !== 'ace' && 'ace/keyboard/' + keyboard;

    this.editor.setKeyboardHandler(handler);
};

Ground.prototype.set = function (option, code) {
    switch(option) {
        case 'language':
            this.setLanguage(code, true);
            break;
        case 'theme':
            this.setTheme(code);
            break;
        case 'indent':
            this.setIndent(code);
            break;
        case 'keyboard':
            this.setKeyboard(code);
            break;
    }
};

Ground.prototype.on = function (event, callback) {
    this.editor.on(event, callback);
};

Ground.prototype.addCommand = function (name, keys, button) {
    var win = keys[0],
        mac = keys[1];

    // Add command inside editor
    this.commands.addCommand({
        name: name,
        bindKey: {win: win,  mac: mac},
        exec: function(editor) { button.click(); },
        readOnly: false
    });

    // Add command outside editor
    Mousetrap.bindGlobal([win.toLowerCase(), mac.toLowerCase()], function(e) {
        button.click();
        // Returning false here is preventing key default behavior
        return false;
    });
};
