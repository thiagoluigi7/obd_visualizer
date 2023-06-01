import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../modules/connection/bluetooth_connection/bluetooth_connection.dart';
import '../modules/input_data/engine_speed/engine_speed.dart';
import '../utils/globals.dart';
import 'base.widget.dart';

class EngineSpeedWidget extends StatefulWidget {
  const EngineSpeedWidget({super.key, required this.bt});

  final Bluetooth bt;

  @override
  EngineSpeedWidgetState createState() => EngineSpeedWidgetState();
}

class EngineSpeedWidgetState extends State<EngineSpeedWidget> {
  late final Timer timer;
  EngineSpeedData data = EngineSpeedData();
  late String name = data.name;
  late String parsedValue = data.value(null, null);

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (Globals.debugMode.value && !Globals.disableEngineSpeedMock.value) {
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

  setParsedValue(int? a, int? b) {
    setState(() => parsedValue = data.value(a, b));
  }

  getMockValue() {
    Random random = Random();
    int a = random.nextInt(100);
    int b = random.nextInt(100);
    setParsedValue(a, b);
  }

  getValue(bt) {
    if (bt.connection == null || !bt.connection?.isConnected) {
      setParsedValue(null, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(name: name, parsedValue: parsedValue);
  }
}
