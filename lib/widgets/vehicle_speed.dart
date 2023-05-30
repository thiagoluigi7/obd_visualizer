
import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../modules/connection/bluetooth_connection/bluetooth_connection.dart';
import '../modules/input_data/vehicle_speed/vehicle_speed.dart';
import 'base.dart';

class VehicleSpeed extends StatefulWidget {
  const VehicleSpeed({
    super.key,
    required this.bt
  });

  final Bluetooth bt;

  @override
  VehicleSpeedState createState() => VehicleSpeedState();
}

class VehicleSpeedState extends State<VehicleSpeed> {
  late final Timer timer;
  VehicleSpeedData data = VehicleSpeedData();
  late String name = data.name;
  late String parsedValue = data.value();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      getValue(widget.bt);
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  getValue(bt) {
    Random random = Random();
    int a = random.nextInt(255);
    setState(() => parsedValue = data.value(a));
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(name: name, parsedValue: parsedValue);
  }
}