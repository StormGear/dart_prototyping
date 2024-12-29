import 'package:flutter_map_math/flutter_geo_math.dart';

void nearestDriver() {
  List<Map<String, dynamic>> drivers = [];
  Map<String, dynamic> userLoc = {
    'latitude': 5.72282776315656,
    'longitude': -0.2978469058871269
  };

  Map<String, dynamic> driver1Loc = {
    'latitude': 5.6674883,
    'longitude': -0.20804
  };
  Map<String, dynamic> driver2Loc = {
    'latitude': 5.694617,
    'longitude': -0.20804
  };

  // Calculate distances
  double distanceToDriver1 = FlutterMapMath().distanceBetween(
      userLoc['latitude'],
      userLoc['longitude'],
      driver1Loc['latitude'],
      driver1Loc['longitude'],
      'meters');

  double distanceToDriver2 = FlutterMapMath().distanceBetween(
      userLoc['latitude'],
      userLoc['longitude'],
      driver2Loc['latitude'],
      driver2Loc['longitude'],
      'meters');

  // Add drivers to the list with their distances
  drivers.add({'driver': 'Driver 1', 'distance': distanceToDriver1});
  drivers.add({'driver': 'Driver 2', 'distance': distanceToDriver2});

  // Sort drivers by distance (ascending)
  drivers.sort((a, b) => a['distance'].compareTo(b['distance']));

  // Print the sorted drivers
  for (var driver in drivers) {
    print('${driver['driver']} is ${driver['distance']} meters away');
  }
}
