import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


Map<String, dynamic> countriesIsoCodes = {};
Map<String, List<String>> cities = {};

/// retrieve all countries
Future<List<String>?> getAllCountries() async {
  try {
    List<String>? countries = [];
    final response = await http.get(
      Uri.parse(
          'https://mycleanapp-backend-tgd5.onrender.com/setPrice/getActiveCities'),
      headers: {
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (int i = 0; i < data.length; i++) {
        // print(data[i]['countryISOCode']);
        countries.add(data[i]['countryISOCode']);
      }
      return countries;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<List<String>?> getCitiesForCountry(String country) async {
  List<String> cities = [];
  final response = await http.get(
    Uri.parse(
        'https://mycleanapp-backend-tgd5.onrender.com/setPrice/getCitiesByCountry/$country'),
    headers: {
      'accept': '*/*',
    },
  );

  if (response.statusCode == 200) {
    // print('Response data: ${response.body}');
    final data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      cities.add(data[i]['city']);
    }
    return cities;
  } else {
    print('Request failed with status: ${response.statusCode}');
    return null;
  }
}

Future<Map<String, List<String>>> createMapFromLists() async {
  Map<String, List<String>> resultMap = {};

  List<String>? list2 = await getAllCountries();
  if (list2 == null) {
    print('Request for countries failed');
    return {};
  }
  for (String key in list2) {
    // Assuming the network request uses the key in the URL
    List<String>? response = await getCitiesForCountry(key);

    if (response != null && response.isNotEmpty) {
      // Assign the key and the entire list (data) as the value
      resultMap[key] = response;
    } else {
      print('Request for $key failed with status: response: $response');
      // Optionally handle the error, e.g., by setting a default value
      resultMap[key] = [];
    }
  }
  cities = resultMap;
  return resultMap;
}

Future<void> loadCountriesCorrespondingISOCodes() async {
  // Step 1: Locate and read the JSON file
  final file = File('./bin/countries.json');
  // Step 2: Read the file as a string
  String jsonString = await file.readAsString();
  final data = await jsonDecode(jsonString);
  countriesIsoCodes = data;
}

dynamic convertIsoCodesToCountry(Map<String, dynamic> listOfCountries) {
  Map<String, List<String>> updatedMap = {};
  for (var countryIso in countriesIsoCodes.keys) {
    for (var country in listOfCountries.keys) {
      if (country == countryIso) {
        updatedMap[countriesIsoCodes[country]] = listOfCountries[country];
      }
    }
  }
  return updatedMap;
}

// Map<String, List<String>> result = await createMapFromLists();
Map<String, List<String>> result = {
  'GH': ['Madina', 'Tema', 'Kasoa', 'Dansoman'],
  'NG': ['Lagos', 'Abuja', 'Kano', 'Ibadan'],
  'KE': ['Nairobi', 'Mombasa', 'Kisumu', 'Nakuru'],
  'ZA': ['Johannesburg', 'Cape Town', 'Durban', 'Pretoria'],
};