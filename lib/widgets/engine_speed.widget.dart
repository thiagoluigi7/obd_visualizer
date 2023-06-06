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
      if (Globals.debugMode.value && Globals.enableEngineSpeedMock.value) {
        getMockValue();
      } else if (!Globals.debugMode.value || (Globals.debugMode.value && Globals.enableEngineSpeedAuto.value)) {
        getValue();
      } else {
        setParsedValue(null, null);
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

  sendData() {
    widget.bt.sendData(data.pid);
  }

  receiveData() {
    return widget.bt.receiveData();
  }

  getValue() async {
    debugPrint('Getting auto engine speed data');
    if (widget.bt.connection == null || !widget.bt.connection!.isConnected) {
      setParsedValue(null, null);
      return;
    }

    await sendData();
    String receivedData = receiveData();
    var splitData = receivedData.split(' ');
    int firstIntValue = int.parse(splitData[2], radix: 16);
    int secondIntValue = int.parse(splitData[3], radix: 16);
    debugPrint('Getting auto engine speed data');
    // setParsedValue(firstIntValue, secondIntValue);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(name: name, parsedValue: parsedValue, sendData: getValue);
  }
}
