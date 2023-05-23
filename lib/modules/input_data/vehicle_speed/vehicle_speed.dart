import '../input_data.dart';

class VehicleSpeedData extends InputData {
  @override
  String name = 'Vehicle Speed';
  @override
  String description = 'Get the current speed of the vehicle';
  @override
  String unit = 'Km/h';
  @override
  Function formula = (int a) => a;
  @override
  String pid = '01 0D';
  @override
  int length = 1;
}
