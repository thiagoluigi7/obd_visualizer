import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TelaprincipalWidget extends StatefulWidget {
  @override
  _TelaprincipalWidgetState createState() => _TelaprincipalWidgetState();
}

class _TelaprincipalWidgetState extends State<TelaprincipalWidget> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator TelaprincipalWidget - FRAME

    return Container(
        width: 1280,
        height: 720,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              top: 50,
              left: 1126,
              child: SizedBox(
                  width: 79,
                  height: 77,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 16,
                        left: 24,
                        child: SvgPicture.asset('assets/images/vector.svg',
                            semanticsLabel: 'vector')),
                  ]))),
          Positioned(
              top: 256,
              left: 881,
              child: SizedBox(
                  width: 324,
                  height: 309,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 113,
                        left: 205,
                        child: Container(
                            width: 80,
                            height: 83,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/Fuelicon.png'),
                                  fit: BoxFit.fitWidth),
                            ))),
                    const Positioned(
                        top: 127,
                        left: 53,
                        child: Text(
                          '-- %',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 36,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                  ]))),
          Positioned(
              top: 256,
              left: 478,
              child: SizedBox(
                  width: 324,
                  height: 309,
                  child: Stack(children: const <Widget>[
                    Positioned(
                        top: 117,
                        left: 81,
                        child: Text(
                          '-- Km/h',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 36,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                  ]))),
          Positioned(
              top: 256,
              left: 75,
              child: SizedBox(
                  width: 324,
                  height: 309,
                  child: Stack(children: const <Widget>[
                    Positioned(
                        top: 128,
                        left: 51,
                        child: Text(
                          '-- rpm',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 36,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                  ]))),
          const Positioned(
              top: 50,
              left: -73,
              child: Text(
                'Tela Inicial',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Inter',
                    fontSize: 36,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
        ]));
  }
}
