import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:obd_visualizer/widgets/device_list_item.widget.dart';

class DeviceList extends StatefulWidget {
  DeviceList({
    super.key,
    required this.devices,
    required this.getConnection,
  });

  List<BluetoothDevice> devices = [];
  Function getConnection;

  @override
  DeviceListState createState() => DeviceListState();
}

class DeviceListState extends State<DeviceList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      height: 150.0,
      width: 500.0,
      child: ListView.builder(
          padding: const EdgeInsets.all(2),
          itemCount: widget.devices.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                padding: const EdgeInsets.all(15),
                child: DeviceListItem(
                    name: widget.devices[index].name,
                    address: widget.devices[index].address,
                    device: widget.devices[index],
                    getConnection: widget.getConnection));
          }),
    );
  }
}
