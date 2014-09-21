function Ground(editor, language, theme, indent, keyboard) {
    this._editor = editor;

    if (this.getCode() !== "")
        this.setLanguage(language, true);
    else
        this.setLanguage(language);

    this.setTheme(theme);
    this.setIndent(indent);
    this.setKeyboard(keyboard);
}

Ground.prototype.getCode = function () {
    return this._editor.getValue();
};

Ground.prototype.getLanguage = function () {
    return this._language;
};

Ground.prototype.setCursor = function (cursor) {
    var lastLine = this._editor.session.getLength();
    this._editor.gotoLine(lastLine);
    this._editor.focus();
};

Ground.prototype.setCode = function (code) {
    this._editor.setValue(code);
}

Ground.prototype.setLanguage = function (language, withoutSample) {
    this._language = language;
    this._editor.getSession().setMode("ace/mode/" + utils.getMode(language));
    if (!withoutSample)
        this.setCode(utils.getSample(language));
    this.setCursor();
};

Ground.prototype.setTheme = function (theme) {
    this._editor.setTheme("ace/theme/" + theme);
};

Ground.prototype.setIndent = function (indent) {
    if (indent == "tab") {
        this._editor.getSession().setUseSoftTabs(false);
        this._editor.getSession().setTabSize(8);
    } else {
        this._editor.getSession().setUseSoftTabs(true);
        this._editor.getSession().setTabSize(indent);
    }
};

Ground.prototype.setKeyboard = function (keyboard) {
    var keyboardHandler = null;
    
    if (keyboard !== 'ace') {
        keyboardHandler = "ace/keyboard/" + keyboard;
    }
    this._editor.setKeyboardHandler(keyboardHandler);
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
}