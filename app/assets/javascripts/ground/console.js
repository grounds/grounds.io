function Console() {
    this.output = $('.output');
    this.connectError = $('#connect_error');
    this.waiting = $('#waiting');
}

Console.prototype.clean = function() {
    this.connectError.hide();
    this.output.find('span').each(function() {
        this.remove();
    });
};

Console.prototype.startWaiting = function() {
    this.clean();
    this.waiting.show();
};

Console.prototype.stopWaiting = function() {
    this.waiting.hide();
};

Console.prototype.write = function(stream, chunk) {
    switch (stream) {
        case 'status':
            this.stopWaiting();
            chunk = '[Program exited with status: ' + chunk + ']';
            break;
        case 'error':
            stream = 'stderr';
            this.stopWaiting();
            this.clean();
            break;
    }
    this.output.append($('<span class="'+stream+'">').text(chunk));
};

Console.prototype.error = function(error) {
    this.stopWaiting();
    this.clean();
    this.connectError.show();
};
