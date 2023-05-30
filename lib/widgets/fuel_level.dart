
import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../modules/connection/bluetooth_connection/bluetooth_connection.dart';
import '../modules/input_data/fuel_level/fuel_level.dart';
import 'base.dart';

class FuelLevel extends StatefulWidget {
  const FuelLevel({
    super.key,
    required this.bt
  });

  final Bluetooth bt;

  @override
  FuelLevelState createState() => FuelLevelState();
}

class FuelLevelState extends State<FuelLevel> {
  late final Timer timer;
  FuelLevelData data = FuelLevelData();
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

  getValue(bt) async {
    if (widget.bt.connection != null && widget.bt.connection!.isConnected) {
      await widget.bt.sendData(data.pid);
      String receivedData = widget.bt.receiveData();
      setState(() => parsedValue = data.value(receivedData));
    }
    setState(() => parsedValue = data.value());
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(name: name, parsedValue: parsedValue);
  }
}