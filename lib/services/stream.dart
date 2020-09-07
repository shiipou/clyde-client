import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:let_log/let_log.dart';
import 'package:msgpack_dart/msgpack_dart.dart' as m2;

import 'package:web_socket_channel/io.dart' as WS;
import 'package:flutter/services.dart' as FILE;

class StreamChannel<T extends StreamProvider> {
  T chan;
  Map<String, StreamController<dynamic>> _events = Map();

  StreamChannel({this.chan});

  Stream<dynamic> get(String event) {
    //? This is ignored because closed after using the this.close()
    //? But Flutter doesn't detect that I did it;
    // ignore: close_sinks
    StreamController<dynamic> controller;
    if (this._events.containsKey(event)) {
      controller = this._events[event];
    } else {
      this._events[event] = controller = StreamController.broadcast();
    }

    this.chan.get(event).listen((dynamic data) {
      controller.sink.add(data);
    });

    return controller.stream.asBroadcastStream();
  }

  void send(String event, List<dynamic> data) {
    this.chan.send(event, data);
  }

  void close() {
    this._events.forEach((String event, StreamController<dynamic> stream) {
      stream.sink.close();
    });
    this.chan.close();
  }
}

mixin StreamProvider {
  void close();
  Stream<dynamic> get(String event);
  void send(String event, dynamic data);
  Stream<void> onConnected();
  Stream<void> onConnectionLost();
}

class StreamWebSocket implements StreamProvider {
  WS.IOWebSocketChannel socket;

  StreamWebSocket({this.socket});

  @override
  void close() {
    this.socket.sink.close();
  }

  @override
  Stream<dynamic> get(String event) {
    // ignore: close_sinks
    StreamController<dynamic> controller = StreamController();
    socket.stream.listen((packets) {
      dynamic msgpack = m2.deserialize(packets);
      //? this `msgpack['event']` emulate Socket.IO channels but the server must handle it
      if (msgpack['event']) {
        dynamic data = msgpack['data'];

        Logger.net('/$event', type: 'webSocket');
        Logger.endNet('/$event',
            type: 'webSocket', data: {'event': 'recieve', 'data': data});

        controller.sink.add(data);
      }
    });
    return controller.stream;
  }

  @override
  Stream<void> onConnected() {
    return this.get('connect');
  }

  @override
  Stream<void> onConnectionLost() {
    return this.get('disconnected');
  }

  @override
  void send(String event, dynamic data) {
    Logger.net('/$event', type: 'webSocket');
    Logger.endNet('/$event',
        type: 'webSocket', data: {'event': 'send', 'data': data});
    //? this `event/data` key emulate Socket.IO channels but the server must handle it.
    Uint8List msgpack = m2.serialize({'event': event, 'data': data});
    this.socket.sink.add(msgpack);
  }
}

class StreamFile implements StreamProvider {
  String socket;
  // ignore: close_sinks
  StreamController<dynamic> _connect = StreamController.broadcast();

  StreamFile({this.socket}) {
    this._connect.sink.add(null);
  }

  @override
  void close() {
    this.socket = null;
    this._connect.sink.close();
  }

  @override
  Stream<dynamic> get(String event) {
    // ignore: close_sinks
    StreamController<dynamic> controller = StreamController();

    FILE.rootBundle.loadString('assets/api/$event.json').then((value) {
      Logger.net('/$event',
          type: 'File', data: {'event': 'recieve', 'data': value});
      controller.sink.add(json.decode(value));
    });

    return controller.stream;
  }

  @override
  Stream<void> onConnected() {
    // ignore: close_sinks
    StreamController<String> controller = this._connect;

    controller.add(null);

    return controller.stream.asBroadcastStream();
  }

  @override
  Stream<void> onConnectionLost() {
    // Can't disconnect from a file.
    return StreamController<void>().stream.asBroadcastStream();
  }

  @override
  void send(String event, dynamic data) {
    Logger.net('/$event',
        type: 'File', data: {'event': 'recieve', 'data': data});
    // file can't handle any messages
  }
}
