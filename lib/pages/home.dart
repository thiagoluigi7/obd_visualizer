import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:obd2_plugin/obd2_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OBD Visualizer',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'OBD Visualizer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  Obd2Plugin obd2 = Obd2Plugin();
  bool enabled = false;
  bool connected = false;
  late List<BluetoothDevice> devices;
  late BluetoothDevice device;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _deviceName = '';

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _checkEnabled() async {
    log(widget.enabled.toString());
    widget.enabled = await widget.obd2.enableBluetooth;
    log(widget.enabled.toString());
  }

  void _checkConnected() async {
    log(widget.connected.toString());
    widget.connected = await widget.obd2.hasConnection;
    log(widget.connected.toString());
  }

  void _getDevices() async {
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted) {
      widget.devices =
          (await widget.obd2.getPairedDevices).cast<BluetoothDevice>();
      widget.device =
          widget.devices.singleWhere((element) => element.name == "DELL-G15");
      _deviceName = widget.device.name ?? '';
      log(widget.device.name ?? '');
    }
  }

  void _getConnection() async {
    widget.obd2.getConnection(widget.device, (connection) {
      log("connected to bluetooth device.");
    }, (message) {
      log("error in connecting: $message");
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Text(_deviceName)]),
              Column(children: <Widget>[
                IconButton(
                    icon: const Icon(Icons.bluetooth),
                    tooltip: 'Check enabled bluetooth',
                    onPressed: _checkEnabled),
                // const Text('Check enabled bluetooth'),
              ]),
              Column(children: <Widget>[
                IconButton(
                    icon: const Icon(Icons.bluetooth_connected),
                    tooltip: 'Check connected',
                    onPressed: _checkConnected),
                // const Text('Check connected'),
              ]),
              Column(children: <Widget>[
                IconButton(
                    icon: const Icon(Icons.bluetooth_drive_outlined),
                    tooltip: 'Get paired bluetooth device',
                    onPressed: _getDevices),
                // const Text('Get paired bluetooth device'),
              ]),
              Column(children: <Widget>[
                IconButton(
                    icon: const Icon(Icons.bluetooth_audio),
                    tooltip: 'Get connection',
                    onPressed: _getConnection),
                // const Text('Get connection'),
              ])
            ]),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
