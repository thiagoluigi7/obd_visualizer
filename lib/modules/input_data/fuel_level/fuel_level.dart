import '../input_data.dart';

class FuelLevelData extends InputData {
  FuelLevelData();
  @override
  String name = 'Fuel Level';
  @override
  String description = 'Get the fuel level in the tank';
  @override
  String unit = '%';
  @override
  Function formula = (int a) => (100 / 255) * a;
  @override
  String pid = '01 2F';
  @override
  int length = 1;
  @override
  late Function value = (int? a) => a == null? '- $unit' : '${formula(a)} $unit';
}
