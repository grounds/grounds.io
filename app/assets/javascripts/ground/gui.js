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

GUI.prototype.submitShareFormWith = function(attributes) {
    var self = this;
    $.each(attributes, function(key, value) {
        self.form[key].val(value);
    });
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
    this.ground.focus();
};

GUI.prototype.scrollToTop = function() {
    $('body').animate({scrollTop: 0}, 'fast');
};

GUI.prototype.switchToSelectedOption = function(option, selected) {
    var code  = selected.data(option),
        label = selected.text();

    this.ground.set(option, code);
    this.dropdownUpdate(option, label);
};

GUI.prototype.bindEvents = function() {
    var self = this;
    this.button.share.on('click', function(event) {
        self.submitShareFormWith(self.ground.getAttributes());
    });

    this.button.run.on('click', function(event) {
        self.disableRunButtonFor(500);
        self.client.send('run', self.ground.getAttributes());
    });

    this.button.back.on('click', function(event) {
        self.scrollToTop();
        self.ground.focus();
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

    this.ground.on('input', function() {
        self.sharedURL.hide();
    });
};
