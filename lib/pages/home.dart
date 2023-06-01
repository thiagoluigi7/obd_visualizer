import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:obd_visualizer/widgets/engine_speed.widget.dart';
import 'package:obd_visualizer/widgets/fuel_level.widget.dart';
import 'package:obd_visualizer/widgets/vehicle_speed.widget.dart';

import '../modules/connection/bluetooth_connection/bluetooth_connection.dart';
import '../utils/globals.dart';
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

  setDebugMode(bool value) {
    Globals.debugMode.value = value;
  }

  setMock(bool value, String field) {
    switch (field) {
      case 'FUEL':
        Globals.disableFuelLevelMock.value = value;
        break;
      case 'SPEED':
        Globals.disableVehicleSpeedMock.value = value;
        break;
      case 'RPM':
        Globals.disableEngineSpeedMock.value = value;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    const Text('Debug Mode'),
                    ValueListenableBuilder<bool>(
                        valueListenable: Globals.debugMode,
                        builder: (context, value, Widget? child) {
                          return Switch(
                            value: value,
                            onChanged: setDebugMode,
                          );
                        }
                    ),
                    const SizedBox(width: 500),
                    IconButton(
                      icon: const Icon(Icons.bluetooth),
                      tooltip: 'Get paired bluetooth device',
                      padding: const EdgeInsets.all(50),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyConfigPage(
                                  title: widget.title, bt: widget.bt)),
                        )
                      }),
                  ]),
                ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  VehicleSpeedWidget(bt: widget.bt),
                  EngineSpeedWidget(bt: widget.bt),
                  ValueListenableBuilder<bool>(
                    valueListenable: Globals.disableFuelLevelMock,
                    builder: (context, value, Widget? child) {
                      return FuelLevelWidget(bt: widget.bt);
                    },
                  )
                ]),
            const SizedBox(height: 10),
            // TODO: Add switch to enable and disable data retrieval periodically
            ValueListenableBuilder<bool>(
                valueListenable: Globals.debugMode,
                builder: (context, value, Widget? child) {
                  return Visibility(
                    visible: value,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Speed Mock'),
                            ValueListenableBuilder<bool>(
                                valueListenable: Globals.disableVehicleSpeedMock,
                                builder: (context, value, Widget? child) {
                                  return Switch(
                                    value: value,
                                    onChanged: (bool newValue) {
                                      setMock(newValue, 'SPEED');
                                    },
                                  );
                                }
                            ),
                            const SizedBox(width: 90),
                            const Text('RPM Mock'),
                            ValueListenableBuilder<bool>(
                                valueListenable: Globals.disableEngineSpeedMock,
                                builder: (context, value, Widget? child) {
                                  return Switch(
                                    value: value,
                                    onChanged: (bool newValue) {
                                      setMock(newValue, 'RPM');
                                    },
                                  );
                                }
                            ),
                            const SizedBox(width: 90),
                            const Text('Fuel Mock'),
                            ValueListenableBuilder<bool>(
                                valueListenable: Globals.disableFuelLevelMock,
                                builder: (context, value, Widget? child) {
                                  return Switch(
                                    value: value,
                                    onChanged: (bool newValue) {
                                      setMock(newValue, 'FUEL');
                                    },
                                  );
                                }
                            ),
                          ],
                        )
                    ),
                  );
                }),
            const SizedBox(height: 10),
            ValueListenableBuilder<bool>(
                valueListenable: Globals.debugMode,
                builder: (context, value, Widget? child) {
                  return Visibility(
                    visible: value,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Debug mode: ${Globals.debugMode.value.toString()}'),
                              const SizedBox(width: 10),
                              Text('Connected: ${widget.bt.connection?.isConnected.toString()}'),
                              const SizedBox(width: 10),
                              // TODO: Add pid being sent by info widget
                              Text('AAAAAAAAAAAAAA'),
                              // TODO: Add input sink and output sink
                              // Text('Connected: ${widget.bt.connection?.isConnected.toString()}')
                            ],
                          )
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
