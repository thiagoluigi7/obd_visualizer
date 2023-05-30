import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'dart:async';


import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../connection.dart';

class Bluetooth extends Connection {
  final FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;

  Future<bool?> get isAvailable async {
    return await bluetooth.isAvailable;
  }

  Future<BluetoothState> get bluetoothState async {
    return bluetooth.state;
  }

  Future<bool> get isBluetoothEnabled async {
    if ((await bluetoothState) == BluetoothState.STATE_ON) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> enableBluetooth() async {
    if ((await bluetoothState) == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
    }
  }

  Future<void> disableBluetooth() async {
    if ((await bluetoothState) == BluetoothState.STATE_ON) {
      await FlutterBluetoothSerial.instance.requestDisable();
    }
  }

  Future<bool> isPaired(BluetoothDevice device) async {
    return (await bluetooth.getBondStateForAddress(device.address)).isBonded;
  }

  Future<List<BluetoothDevice>> getPairedDevices() async {
    return bluetooth.getBondedDevices();
  }

  Future<List<BluetoothDevice>> getNearbyDevices() async {
    List<BluetoothDevice> discoveredDevices = [];
    return bluetooth.startDiscovery().listen((event) {
      final existingIndex = discoveredDevices
          .indexWhere((element) => element.address == event.device.address);
      if (existingIndex >= 0) {
        discoveredDevices[existingIndex] = event.device;
      } else {
        if (event.device.name != null) {
          discoveredDevices.add(event.device);
        }
      }
    }).asFuture(discoveredDevices);
  }

  Future<List<BluetoothDevice>> getNearbyPairedDevices() async {
    List<BluetoothDevice> discoveredDevices = [];
    return bluetooth.startDiscovery().listen((event) async {
      final existingIndex = discoveredDevices
          .indexWhere((element) => element.address == event.device.address);
      if (existingIndex >= 0) {
        if (await isPaired(event.device)) {
          discoveredDevices[existingIndex] = event.device;
        }
      } else {
        if (event.device.name != null) {
          discoveredDevices.add(event.device);
        }
      }
    }).asFuture(discoveredDevices);
  }

  Future<bool> pairWithDevice(BluetoothDevice device) async {
    bool? isPaired = await bluetooth.bondDeviceAtAddress(device.address);
    if (isPaired != null) {
      return isPaired;
    }
    return false;
  }

  Future<bool> unpairDevice(BluetoothDevice device) async {
    bool? isUnpaired =
        await bluetooth.removeDeviceBondWithAddress(device.address);
    if (isUnpaired != null) {
      return isUnpaired;
    }
    return false;
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    if (connection != null) {
      await connection?.finish();
    }
    connection = await BluetoothConnection.toAddress(device.address);
  }

  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    if (connection?.isConnected == true) {
      await connection?.close();
      connection = null;
    } else {
      connection = null;
    }
  }

  @override
  bool isConnected() {
    if (connection != null) {
      return true;
    }
    return false;
  }

  @override
  Future<void> sendData(String command) async {
    if (connection != null) {
      connection?.output.add(Uint8List.fromList(utf8.encode("$command\r\n")));
      await connection?.output.allSent;
    }
  }

  @override
  String receiveData() {
    String response = "";
    connection?.input?.listen((Uint8List data) {
      Uint8List bytes = Uint8List.fromList(data.toList());
      String string = String.fromCharCodes(bytes);
      response += string;
    });
    return response;
  }
}
