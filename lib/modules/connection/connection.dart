import 'dart:async';
import 'dart:typed_data';

abstract class Connection {
  bool isConnected();
  Future<void> sendData(String command);
  String receiveData();
}
