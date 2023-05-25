
import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../modules/connection/bluetooth_connection/bluetooth_connection.dart';
import '../modules/input_data/engine_speed/engine_speed.dart';
import 'base.dart';

class EngineSpeed extends StatefulWidget {
  EngineSpeed({
    super.key,
    required this.bt
  });

  final Bluetooth bt;

  @override
  EngineSpeedState createState() => EngineSpeedState();
}

class EngineSpeedState extends State<EngineSpeed> {
  late final Timer timer;
  EngineSpeedData data = EngineSpeedData();
  late String name = data.name;
  late String parsedValue = data.value(a, b);
  int a = 5;
  int b = 10;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
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
    int a = random.nextInt(100);
    int b = random.nextInt(100);
    setState(() => parsedValue = data.value(a, b));
  }

  Widget build(BuildContext context) {
    return BaseWidget(name: name, parsedValue: parsedValue);
  }
}