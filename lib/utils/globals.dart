import 'package:flutter/material.dart';

class Globals {
  static ValueNotifier<bool> debugMode = ValueNotifier<bool>(false);
  static ValueNotifier<bool> enableVehicleSpeedMock = ValueNotifier<bool>(false);
  static ValueNotifier<bool> enableEngineSpeedMock = ValueNotifier<bool>(false);
  static ValueNotifier<bool> enableFuelLevelMock = ValueNotifier<bool>(false);
  static ValueNotifier<bool> enableVehicleSpeedAuto = ValueNotifier<bool>(false);
  static ValueNotifier<bool> enableEngineSpeedAuto = ValueNotifier<bool>(false);
  static ValueNotifier<bool> enableFuelLevelAuto = ValueNotifier<bool>(false);
}
