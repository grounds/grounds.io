function GUI(ground, client) {
    this.ground = ground;
    this.client = client;

    this.sharedURL = $('#sharedURL').hide();

    this.button = {
        share: $('#share'),
        run: $('#run'),
        back: $('#back'),
    };

    this.form = {
        obj: $('#share_ground'),
        code: $('#ground_code'),
        language: $('#ground_language'),
    };

    this.options = {
        language: $('.language-selection'),
        theme: $('.theme-selection'),
        indent: $('.indent-selection'),
        keyboard: $('.keyboard-selection'),
    };

    this.keys = {
        'share': ['Ctrl+S', 'Command+S'],
        'run': ['Ctrl+Enter', 'Command+Enter'],
        'back': ['Ctrl+Backspace', 'Command+Backspace']
    };

    this.bindEvents();
}

GUI.prototype.submitShareFormWith = function(language, code) {
    this.form.language.val(language);
    this.form.code.val(code);
    this.form.obj.submit();
};

GUI.prototype.disableRunButtonFor = function(milliseconds) {
    this.button.run.attr('disabled', 'disabled');

    var self = this;
    setTimeout(function() {
        self.button.run.removeAttr('disabled');
    }, milliseconds);
};

GUI.prototype.dropdownUpdate = function(option, label) {
    $('a[data-dropdown="' + option + '-dropdown"]').click();
    $('#' + option + '-name').text(label);
    this.ground.focusEditor();
};

GUI.prototype.scrollToTop = function() {
    $('body').animate({scrollTop: 0}, 'fast');
};

GUI.prototype.switchToSelectedOption = function(option, selected) {
    var code = selected.data(option),
        label = selected.text();

    this.ground.set(option, code);
    this.dropdownUpdate(option, label);
};

GUI.prototype.bindEvents = function() {
    var self = this;
    this.button.share.on('click', function(event) {
        var language = self.ground.getLanguage(),
            code = self.ground.getCode();

        self.submitShareFormWith(language, code);
    });

    this.button.run.on('click', function(event) {
        self.disableRunButtonFor(500);

        var language = self.ground.getLanguage(),
            code = self.ground.getCode();

        self.client.send('run', { language: language, code: code });
    });

    this.button.back.on('click', function(event) {
        self.scrollToTop();
        self.ground.focusEditor();
    });

    // Add key bindings
    $.each(this.button, function(name, button) {
        var keys = self.keys[name];

        if (!keys) return;

        self.ground.addCommand(name, keys, button);
    });

    $.each(this.options, function(option, code) {
        code.on('click', function(event, date) {
            self.switchToSelectedOption(option, $(this));
        });
    });

    this.form.obj.on('ajax:success', function(data, response, xhr) {
        self.sharedURL.val(response.shared_url).show().focus().select();
    });

    this.ground.editor.on('input', function() {
        self.sharedURL.hide();
    });
};
