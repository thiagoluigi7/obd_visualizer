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
      if (Globals.debugMode.value && Globals.enableVehicleSpeedMock.value) {
        getMockValue();
      } else if (!Globals.debugMode.value || (Globals.debugMode.value && Globals.enableVehicleSpeedAuto.value)){
        getValue();
      } else {
        setParsedValue(null);
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

  sendData() {
    widget.bt.sendData(data.pid);
  }

  receiveData() {
    return widget.bt.receiveData();
  }

  getValue() async {
    debugPrint('Getting auto vehicle speed data');
    if (widget.bt.connection == null || !widget.bt.connection!.isConnected) {
      setParsedValue(null);
      return;
    }

    await sendData();
    String receivedData = receiveData();
    var splitData = receivedData.split(' ');
    int intValue = int.parse(splitData[2], radix: 16);
    debugPrint('Getting auto vehicle speed data');
    // setParsedValue(intValue);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(name: name, parsedValue: parsedValue, sendData: getValue);
  }
}
