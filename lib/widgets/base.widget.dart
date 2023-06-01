import 'package:flutter/material.dart';

import '../utils/globals.dart';
import '../utils/utils.dart';

class BaseWidget extends StatefulWidget {
  BaseWidget({
    super.key,
    required this.name,
    required this.parsedValue,
    this.sendData,
  });

  String name;
  String parsedValue;
  Function? sendData;

  @override
  BaseWidgetState createState() => BaseWidgetState();
}

class BaseWidgetState extends State<BaseWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Positioned(
            top: 0,
            left: 0,
            child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color.fromRGBO(217, 217, 217, 1)))),
        Column(children: [
          const SizedBox(height: 6),
          Text(widget.name),
          const SizedBox(height: 6),
          Text(widget.parsedValue),
          const SizedBox(height: 6),
          ValueListenableBuilder<bool>(
              valueListenable: Globals.debugMode,
              builder: (context, value, Widget? child) {
                return Visibility(
                    visible: value,
                    child: OutlinedButton(
                      onPressed: () {
                        widget.sendData != null
                            ? widget.sendData!()
                            : showSnackBar(context, 'Method not implemented');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Send data'),
                        ],
                      ),
                    ));
              }
          )
          // const SizedBox(height: 10),
        ])
      ]),
    );
  }
}
