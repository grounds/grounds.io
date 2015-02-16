function Client(endpoint) {
    this._console = new Console();
    this._socket = null;

    this.connect(endpoint);
}

Client.prototype.connect = function(endpoint) {
    if (!endpoint) return;

    // Useful when manually attempting to reconnect.
    // e.g. With turbolinks on page load.
    this._socket = io.connect(endpoint, { 'forceNew': true });
    this.bindEvents();
};

Client.prototype.disconnect = function() {
    if (!this.connected()) return;

    this._socket.io.disconnect();
};

Client.prototype.connected = function() {
    return this._socket && this._socket.connected;
};

Client.prototype.send = function(event, data) {
    if (!this.connected()) return;

    this._console.startWaiting();

    this._socket.emit(event, data);
};

Client.prototype.bindEvents = function() {
    var self = this;
    this._socket.on('run', function(data) {
        self._console.write(data.stream, data.chunk);
    }).on('connect', function() {
        self._console.clean();
    }).on('connect_error', function() {
        self._console.error();
    });
};
