import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../modules/connection/bluetooth_connection/bluetooth_connection.dart';
import '../widgets/device_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'OBD Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'OBD Visualizer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  Bluetooth bt = Bluetooth();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BluetoothDevice> devices = [];

  void _getDevices() async {
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted) {
      List<BluetoothDevice> list = await widget.bt.getPairedDevices();
      _setList(list);
    }
  }

  void _setList(List<BluetoothDevice> list) {
    setState(() => {devices = list});
  }

  void _getConnection(BluetoothDevice device) async {
    try {
      await widget.bt.connectToDevice(device);
      _showSnackBar('Conectado!');
    } catch (e) {
      _showSnackBar('Erro na conexão');
    }
  }

  void _showSnackBar(String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                IconButton(
                    icon: const Icon(Icons.clear),
                    tooltip: 'Clear devices list',
                    padding: const EdgeInsets.all(50),
                    onPressed: () => _setList([])),
                IconButton(
                    icon: const Icon(Icons.bluetooth),
                    tooltip: 'Get paired bluetooth device',
                    padding: const EdgeInsets.all(50),
                    onPressed: _getDevices),
              ]),
            ]),
        DeviceList(devices: devices, getConnection: _getConnection)
      ])),
    );
  }
}
