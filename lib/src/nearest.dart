import 'package:geolocator/geolocator.dart';

void nearestDriver() async {
  List<Map<String, dynamic>> drivers = [
  ];
  Map<String, dynamic> userLoc = {
    'latitude': 5.72282776315656,
    'longitude': -0.2978469058871269
  };

  Map<String, dynamic> driver1Loc = {
    'latitude': 5.6674883,
    'longitude': -0.20804
  };
  Map<String, dynamic> driver2Loc = {'lat': 5.694617, 'long': -0.20804};

   // Calculate distances
  double distanceToDriver1 = Geolocator.distanceBetween(
    userLoc['latitude'],
    userLoc['longitude'],
    driver1Loc['latitude'],
    driver1Loc['longitude'],
  );

  double distanceToDriver2 = Geolocator.distanceBetween(
    userLoc['latitude'],
    userLoc['longitude'],
    driver2Loc['latitude'],
    driver2Loc['longitude'],
  );

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
