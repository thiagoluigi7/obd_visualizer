import 'package:flutter/material.dart';

class Globals {
  static ValueNotifier<bool> debugMode = ValueNotifier<bool>(false);
  static ValueNotifier<bool> disableFuelLevelMock = ValueNotifier<bool>(false);
  static ValueNotifier<bool> disableVehicleSpeedMock = ValueNotifier<bool>(false);
  static ValueNotifier<bool> disableEngineSpeedMock = ValueNotifier<bool>(false);
}
