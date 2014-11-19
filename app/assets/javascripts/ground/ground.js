function Ground(params) {
    this.editor = params.editor;

    this.editor.getSession().setUseWorker(false);

    if (this.getCode() !== '')
        this.setLanguage(params.language, true);
    else
        this.setLanguage(params.language);

    this.setTheme(params.theme);
    this.setIndent(params.indent);
    this.setKeyboard(params.keyboard);
}

Ground.prototype.focusEditor = function() {
    this.editor.focus();
};

Ground.prototype.getCode = function () {
    return this.editor.getValue();
};

Ground.prototype.getLanguage = function () {
    return this.language;
};

Ground.prototype.setCursor = function (cursor) {
    var lastLine = this.editor.session.getLength();
    this.editor.gotoLine(lastLine);
    this.editor.focus();
};

Ground.prototype.setCode = function (code) {
    this.editor.setValue(code);
};

Ground.prototype.setLanguage = function (language, withoutSample) {
    this.language = language;
    this.editor.getSession().setMode('ace/mode/' + utils.getMode(language));
    if (!withoutSample)
        this.setCode(utils.getSample(language));
    this.setCursor();
};

Ground.prototype.setTheme = function (theme) {
    this.editor.setTheme('ace/theme/' + theme);
};

Ground.prototype.setIndent = function (indent) {
    if (indent == 'tab') {
        this.editor.getSession().setUseSoftTabs(false);
        this.editor.getSession().setTabSize(8);
    } else {
        this.editor.getSession().setUseSoftTabs(true);
        this.editor.getSession().setTabSize(indent);
    }
};

Ground.prototype.setKeyboard = function (keyboard) {
    var handler = keyboard !== 'ace' && 'ace/keyboard/' + keyboard;

    this.editor.setKeyboardHandler(handler);
};

Ground.prototype.set = function (option, code) {
    switch(option) {
        case 'language':
            this.setLanguage(code);
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

Ground.prototype.addCommand = function (name, keys, button) {
    var win = keys[0],
        mac = keys[1];

    // Add command inside editor
    this.editor.commands.addCommand({
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
