function Client(endpoint) {
    this._console = new Console();
    this._socket = null;

    this.connect(endpoint);
}

Client.prototype.connect = function(endpoint) {
    if (endpoint === null) return;

    this._socket = io.connect(endpoint, {'forceNew':true });
    this.bindEvents();
};

Client.prototype.disconnect = function() {
    if (this.connected() === false) return;

    this._socket.io.disconnect();
};

Client.prototype.connected = function() {
    return this._socket !== null && this._socket.connected;
};

Client.prototype.send = function(event, data) {
    if (this.connected() === false) return;

    this._console.startWaiting();

    this._socket.emit(event, data);
};

Client.prototype.bindEvents = function() {
    var self = this;
    this._socket.on('run', function(data) {
        self._console.write(data.stream, data.chunk);
    });
    this._socket.on('connect', function(data) {
        self._console.clean();
    });
    this._socket.on('connect_error', function() {
        self._console.error();
    });
};
