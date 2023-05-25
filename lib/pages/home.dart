import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:obd_visualizer/widgets/engine_speed.dart';
import 'package:obd_visualizer/widgets/fuel_level.dart';
import 'package:obd_visualizer/widgets/vehicle_speed.dart';

import '../modules/connection/bluetooth_connection/bluetooth_connection.dart';
import 'my_config_page.dart';

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
                    icon: const Icon(Icons.bluetooth),
                    tooltip: 'Get paired bluetooth device',
                    padding: const EdgeInsets.all(50),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyConfigPage(title: widget.title, bt: widget.bt)),
                      )
                    }),
              ]),
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              VehicleSpeed(bt: widget.bt),
              EngineSpeed(bt: widget.bt),
              FuelLevel(bt: widget.bt),
            ]),
      ])),
    );
  }
}
