import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../modules/connection/bluetooth_connection/bluetooth_connection.dart';
import '../modules/input_data/vehicle_speed/vehicle_speed.dart';
import '../utils/globals.dart';
import 'base.widget.dart';

class VehicleSpeedWidget extends StatefulWidget {
  const VehicleSpeedWidget({super.key, required this.bt});

  final Bluetooth bt;

  @override
  VehicleSpeedWidgetState createState() => VehicleSpeedWidgetState();
}

class VehicleSpeedWidgetState extends State<VehicleSpeedWidget> {
  late final Timer timer;
  VehicleSpeedData data = VehicleSpeedData();
  late String name = data.name;
  late String parsedValue = data.value(null);

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (Globals.debugMode.value && !Globals.disableVehicleSpeedMock.value) {
        getMockValue();
      } else {
        getValue(widget.bt);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  setParsedValue(int? a) {
    setState(() => parsedValue = data.value(a));
  }

  getMockValue() {
    Random random = Random();
    int a = random.nextInt(255);
    setParsedValue(a);
  }

  getValue(bt) {
    if (bt.connection == null || !bt.connection?.isConnected) {
      setParsedValue(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(name: name, parsedValue: parsedValue);
  }
}
