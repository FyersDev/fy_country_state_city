import 'package:flutter/material.dart';
import 'package:fy_country_state_city/fy_country_state_city.dart' as fy;

class CitiesView extends StatelessWidget {
  final String stateCode;
  final String countryCode;
  const CitiesView({super.key, required this.stateCode, required this.countryCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cities of $stateCode')),
      body: FutureBuilder<List<fy.City>>(
        future: fetchCities(countryCode, stateCode),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(title: Text(snapshot.data?[index].name ?? ''));
            },
          );
        },
      ),
    );
  }
}

Future<List<fy.City>> fetchCities(String countryCode, String stateCode) async {
  final List<fy.City> cscCities =
      await fy.getStateCities(countryCode, stateCode);
  return cscCities.map((c) => fy.City(name: c.name, countryCode: c.countryCode, stateCode: c.stateCode)).toList();
}
