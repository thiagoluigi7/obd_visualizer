import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

import '../modules/connection/bluetooth_connection/bluetooth_connection.dart';
import '../utils/utils.dart';
import '../widgets/device_list.widget.dart';

class MyConfigPage extends StatefulWidget {
  const MyConfigPage({super.key, required this.title, required this.bt});

  final String title;
  final Bluetooth bt;

  @override
  State<MyConfigPage> createState() => _MyConfigPageState();
}

class _MyConfigPageState extends State<MyConfigPage> {
  List<BluetoothDevice> devices = [];

  void _getDevices() async {
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted) {
      List<BluetoothDevice> list = await widget.bt.getPairedDevices();
      _setList(list);
    }
  }

  void _setList(List<BluetoothDevice> list) {
    setState(() => devices = list);
  }

  void _getConnection(BluetoothDevice device) async {
    try {
      await widget.bt.connectToDevice(device);
      showSnackBar(context, 'Conectado!');
    } catch (e) {
      showSnackBar(context, 'Erro na conexão');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getDevices();
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
                IconButton(
                    icon: const Icon(Icons.home),
                    tooltip: 'Go back home',
                    padding: const EdgeInsets.all(50),
                    onPressed: () => {Navigator.pop(context)}),
              ]),
            ]),
        DeviceList(devices: devices, getConnection: _getConnection)
      ])),
    );
  }
}
