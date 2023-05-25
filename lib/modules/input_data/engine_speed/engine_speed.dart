import '../input_data.dart';

class EngineSpeedData implements InputData {
  EngineSpeedData();
  @override
  String name = 'Engine Speed';
  @override
  String description = 'Get the current engine speed in RPM';
  @override
  String unit = 'RPM';
  @override
  Function formula = (int a, int b) => ((256 * a) + b) / 4;
  @override
  String pid = '01 0C';
  @override
  int length = 2;
  @override
  late Function value = (a, b) => '${formula(a, b)}$unit';
}
