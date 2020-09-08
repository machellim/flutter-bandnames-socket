import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get statusServer => this.serverStatus;
  IO.Socket get socket => this._socket;

  SocketService() {
    this.initConfig();
  }

  void initConfig() {
    this._socket = IO.io('http://192.168.1.108:3000', {
      'transports': ['websocket'],
      'autoConnect': true,
    });
    this._socket.on('connect', (_) {
      this.serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this.serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }
}
