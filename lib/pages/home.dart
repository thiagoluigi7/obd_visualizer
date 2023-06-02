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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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

  resolveStatus(bool newValue, String field, String subField) {
    switch (field) {
      case 'MOCK':
        switch (subField) {
          case 'SPEED':
            Globals.enableVehicleSpeedMock.value = newValue;
            if (newValue == true && Globals.enableVehicleSpeedAuto.value == true) {
              Globals.enableVehicleSpeedAuto.value = false;
            }
            if (newValue == true && Globals.enableVehicleSpeedAuto.value == false) {
              Globals.enableVehicleSpeedAuto.value = false;
            }
            if (newValue == false && Globals.enableVehicleSpeedAuto.value == true) {
              Globals.enableVehicleSpeedAuto.value = true;
            }
            if (newValue == false && Globals.enableVehicleSpeedAuto.value == false) {
              Globals.enableVehicleSpeedAuto.value = false;
            }
            break;
          case 'RPM':
            Globals.enableEngineSpeedMock.value = newValue;
            if (newValue == true && Globals.enableEngineSpeedAuto.value == true) {
              Globals.enableEngineSpeedAuto.value = false;
            }
            if (newValue == true && Globals.enableEngineSpeedAuto.value == false) {
              Globals.enableEngineSpeedAuto.value = false;
            }
            if (newValue == false && Globals.enableEngineSpeedAuto.value == true) {
              Globals.enableEngineSpeedAuto.value = true;
            }
            if (newValue == false && Globals.enableEngineSpeedAuto.value == false) {
              Globals.enableEngineSpeedAuto.value = false;
            }
            break;
          case 'FUEL':
            Globals.enableFuelLevelMock.value = newValue;
            if (newValue == true && Globals.enableFuelLevelAuto.value == true) {
              Globals.enableFuelLevelAuto.value = false;
            }
            if (newValue == true && Globals.enableFuelLevelAuto.value == false) {
              Globals.enableFuelLevelAuto.value = false;
            }
            if (newValue == false && Globals.enableFuelLevelAuto.value == true) {
              Globals.enableFuelLevelAuto.value = true;
            }
            if (newValue == false && Globals.enableFuelLevelAuto.value == false) {
              Globals.enableFuelLevelAuto.value = false;
            }
            break;
        }
        break;
      case 'AUTO':
        switch (subField) {
          case 'SPEED':
            Globals.enableVehicleSpeedAuto.value = newValue;
            if (newValue == true && Globals.enableVehicleSpeedMock.value == true) {
              Globals.enableVehicleSpeedMock.value = false;
            }
            if (newValue == true && Globals.enableVehicleSpeedMock.value == false) {
              Globals.enableVehicleSpeedMock.value = false;
            }
            if (newValue == false && Globals.enableVehicleSpeedMock.value == true) {
              Globals.enableVehicleSpeedMock.value = true;
            }
            if (newValue == false && Globals.enableVehicleSpeedMock.value == false) {
              Globals.enableVehicleSpeedMock.value = false;
            }
            break;
          case 'RPM':
            Globals.enableEngineSpeedAuto.value = newValue;
            if (newValue == true && Globals.enableEngineSpeedMock.value == true) {
              Globals.enableEngineSpeedMock.value = false;
            }
            if (newValue == true && Globals.enableEngineSpeedMock.value == false) {
              Globals.enableEngineSpeedMock.value = false;
            }
            if (newValue == false && Globals.enableEngineSpeedMock.value == true) {
              Globals.enableEngineSpeedMock.value = true;
            }
            if (newValue == false && Globals.enableEngineSpeedMock.value == false) {
              Globals.enableEngineSpeedMock.value = false;
            }
            break;
          case 'FUEL':
            Globals.enableFuelLevelAuto.value = newValue;
            if (newValue == true && Globals.enableFuelLevelMock.value == true) {
              Globals.enableFuelLevelMock.value = false;
            }
            if (newValue == true && Globals.enableFuelLevelMock.value == false) {
              Globals.enableFuelLevelMock.value = false;
            }
            if (newValue == false && Globals.enableFuelLevelMock.value == true) {
              Globals.enableFuelLevelMock.value = true;
            }
            if (newValue == false && Globals.enableFuelLevelMock.value == false) {
              Globals.enableFuelLevelMock.value = false;
            }
            break;
        }
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
                    valueListenable: Globals.enableFuelLevelMock,
                    builder: (context, value, Widget? child) {
                      return FuelLevelWidget(bt: widget.bt);
                    },
                  )
                ]),
            const SizedBox(height: 20),
            ValueListenableBuilder<bool>(
                valueListenable: Globals.debugMode,
                builder: (context, value, Widget? child) {
                  return Visibility(
                    visible: value,
                    child: Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(15),
                        scrollDirection: Axis.vertical,
                        children: [
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child:
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Speed Mock'),
                                      ValueListenableBuilder<bool>(
                                          valueListenable: Globals.enableVehicleSpeedMock,
                                          builder: (context, value, Widget? child) {
                                            return Switch(
                                              value: value,
                                              onChanged: (bool newValue) {
                                                resolveStatus(newValue, 'MOCK', 'SPEED');
                                              },
                                            );
                                          }
                                      ),
                                      const SizedBox(width: 90),
                                      const Text('RPM Mock'),
                                      ValueListenableBuilder<bool>(
                                          valueListenable: Globals.enableEngineSpeedMock,
                                          builder: (context, value, Widget? child) {
                                            return Switch(
                                              value: value,
                                              onChanged: (bool newValue) {
                                                resolveStatus(newValue, 'MOCK', 'RPM');
                                              },
                                            );
                                          }
                                      ),
                                      const SizedBox(width: 90),
                                      const Text('Fuel Mock'),
                                      ValueListenableBuilder<bool>(
                                          valueListenable: Globals.enableFuelLevelMock,
                                          builder: (context, value, Widget? child) {
                                            return Switch(
                                              value: value,
                                              onChanged: (bool newValue) {
                                                resolveStatus(newValue, 'MOCK', 'FUEL');
                                              },
                                            );
                                          }
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Speed Auto'),
                                      ValueListenableBuilder<bool>(
                                          valueListenable: Globals.enableVehicleSpeedAuto,
                                          builder: (context, value, Widget? child) {
                                            return Switch(
                                              value: value,
                                              onChanged: (bool newValue) {
                                                resolveStatus(newValue, 'AUTO', 'SPEED');
                                              },
                                            );
                                          }
                                      ),
                                      const SizedBox(width: 90),
                                      const Text('RPM Auto'),
                                      ValueListenableBuilder<bool>(
                                          valueListenable: Globals.enableEngineSpeedAuto,
                                          builder: (context, value, Widget? child) {
                                            return Switch(
                                              value: value,
                                              onChanged: (bool newValue) {
                                                resolveStatus(newValue, 'AUTO', 'RPM');
                                              },
                                            );
                                          }
                                      ),
                                      const SizedBox(width: 90),
                                      const Text('Fuel Auto'),
                                      ValueListenableBuilder<bool>(
                                          valueListenable: Globals.enableFuelLevelAuto,
                                          builder: (context, value, Widget? child) {
                                            return Switch(
                                              value: value,
                                              onChanged: (bool newValue) {
                                                resolveStatus(newValue, 'AUTO', 'FUEL');
                                              },
                                            );
                                          }
                                      ),
                                    ],
                                  )
                                ],
                              )
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child:
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ValueListenableBuilder<bool>(
                                          valueListenable: Globals.debugMode,
                                          builder: (context, value, Widget? child) {
                                            return Text('Debug mode: ${Globals.debugMode.value.toString()}');
                                          }
                                      ),
                                      const SizedBox(width: 10),
                                      Text('Connected: ${widget.bt.connection?.isConnected.toString()}'),
                                      const SizedBox(width: 10),
                                      // TODO: Add pid being sent by info widget
                                      // TODO: Add input sink and output sink
                                      // Text('Connected: ${widget.bt.connection?.isConnected.toString()}')
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ValueListenableBuilder<bool>(
                                          valueListenable: Globals.enableVehicleSpeedAuto,
                                          builder: (context, value, Widget? child) {
                                            return Text('Speed Auto: ${Globals.enableVehicleSpeedAuto.value}');
                                          }
                                      ),
                                      const SizedBox(width: 10),
                                      ValueListenableBuilder<bool>(
                                          valueListenable: Globals.enableVehicleSpeedMock,
                                          builder: (context, value, Widget? child) {
                                            return Text('Speed Mock: ${Globals.enableVehicleSpeedMock.value}');
                                          }
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ValueListenableBuilder<bool>(
                                          valueListenable: Globals.enableEngineSpeedAuto,
                                          builder: (context, value, Widget? child) {
                                            return Text('RPM Auto: ${Globals.enableEngineSpeedAuto.value}');
                                          }
                                      ),
                                      const SizedBox(width: 10),
                                      ValueListenableBuilder<bool>(
                                          valueListenable: Globals.enableEngineSpeedMock,
                                          builder: (context, value, Widget? child) {
                                            return Text('RPM Mock: ${Globals.enableEngineSpeedMock.value}');
                                          }
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ValueListenableBuilder<bool>(
                                          valueListenable: Globals.enableFuelLevelAuto,
                                          builder: (context, value, Widget? child) {
                                            return Text('Fuel Auto: ${Globals.enableFuelLevelAuto.value}');
                                          }
                                      ),
                                      const SizedBox(width: 10),
                                      ValueListenableBuilder<bool>(
                                          valueListenable: Globals.enableFuelLevelMock,
                                          builder: (context, value, Widget? child) {
                                            return Text('Fuel Mock: ${Globals.enableFuelLevelMock.value}');
                                          }
                                      )
                                    ],
                                  )
                                ]
                              )
                          ),
                        ],
                      ),
                    )
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
