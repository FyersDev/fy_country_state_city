import 'dart:convert';

import '../data/models/city.dart';
import 'package:fy_service_layer/fy_service_layer.dart';

/// Load cities from a country-specific JSON file (more efficient for large countries)
Future<List<City>> _loadCountryCities(String countryCode) async {
  try {
    final res = await FyNetwork.client.get(
      Uri.parse('https://assets.fyers.in/country_package/cities/$countryCode.json'),
    );
    final data = jsonDecode(res.body) as List;
    return List<City>.from(
      data.map((item) => City.fromJson(item)),
    );
  } catch (e) {
    // Fallback to loading all cities if country-specific file doesn't exist
    return await _loadCountryCities(countryCode);
  }
}

/// Get the list of cities that belongs to a country by the country ISO CODE
/// Uses country-specific JSON file for better performance
Future<List<City>> loadCountryCitiesOptimized(String countryCode) async {
  final cities = await _loadCountryCities(countryCode);

  // Filter by country code in case we fell back to loading all cities
  final res = cities.where((city) {
    return city.countryCode == countryCode;
  }).toList();
  res.sort((a, b) => a.name.compareTo(b.name));
  print('res: ${res.runtimeType}');

  return res;
}

/// Get the list of states that belongs to a state by the state ISO CODE and the country ISO CODE
Future<List<City>> getStateCities(String countryCode, String stateCode) async {
  final cities = await loadCountryCitiesOptimized(countryCode);

  final res = cities.where((city) {
    return city.countryCode == countryCode && city.stateCode == stateCode;
  }).toList();
  res.sort((a, b) => a.name.compareTo(b.name));

  return res;
}
