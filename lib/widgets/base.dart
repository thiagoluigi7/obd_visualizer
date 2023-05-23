import 'package:obd_visualizer/modules/connection/connection.dart';

import 'package:flutter/material.dart';

class BaseWidget extends StatefulWidget {
  Connection? connection;
  int? value;

  BaseWidget({super.key});

  @override
  BaseWidgetState createState() => BaseWidgetState();
}

class BaseWidgetState extends State<BaseWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 324,
        height: 309,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 324,
                  height: 309,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color.fromRGBO(217, 217, 217, 1),
                  ))),
        ]));
  }
}
