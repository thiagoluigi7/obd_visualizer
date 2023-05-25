
import 'package:flutter/cupertino.dart';

import '../modules/connection/bluetooth_connection/bluetooth_connection.dart';
import '../modules/input_data/vehicle_speed/vehicle_speed.dart';
import 'base.dart';

class VehicleSpeed extends StatefulWidget {
  VehicleSpeed({
    super.key,
    required this.bt
  });

  final Bluetooth bt;

  @override
  VehicleSpeedState createState() => VehicleSpeedState();
}

class VehicleSpeedState extends State<VehicleSpeed> {
  VehicleSpeedData data = VehicleSpeedData();
  late String name = data.name;
  late String parsedValue = data.value(a);
  int a = 5;

  Widget build(BuildContext context) {
    return BaseWidget(name: name, parsedValue: parsedValue);
  }
}