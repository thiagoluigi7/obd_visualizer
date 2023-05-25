
import 'package:flutter/cupertino.dart';

import '../modules/connection/bluetooth_connection/bluetooth_connection.dart';
import '../modules/input_data/fuel_level/fuel_level.dart';
import 'base.dart';

class FuelLevel extends StatefulWidget {
  FuelLevel({
    super.key,
    required this.bt
  });

  final Bluetooth bt;

  @override
  FuelLevelState createState() => FuelLevelState();
}

class FuelLevelState extends State<FuelLevel> {
  FuelLevelData data = FuelLevelData();
  late String name = data.name;
  late String parsedValue = data.value(a);
  int a = 255;

  Widget build(BuildContext context) {
    return BaseWidget(name: name, parsedValue: parsedValue);
  }
}