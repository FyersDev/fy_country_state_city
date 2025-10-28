import 'package:example_country/state_view.dart';
import 'package:flutter/material.dart';
import 'package:fy_country_state_city/fy_country_state_city.dart' as fy;

class CountryView extends StatelessWidget {
  const CountryView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<fy.Country>>(
      future: fetchCountries(),
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
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StateView(
                        countryCode: snapshot.data?[index].isoCode ?? ''),
                  ),
                );
              },
              child: ListTile(
                title: Text(snapshot.data?[index].name ?? ''),
              ),
            );
          },
        );
      },
    );
  }
}

/// Fetch countries and convert them to the local Country model.
Future<List<fy.Country>> fetchCountries() async {
  final List<fy.Country> cscCountries = await fy.getAllCountries();
  return cscCountries
      .map((c) => fy.Country(
            name: c.name,
            isoCode: c.isoCode,
            phoneCode: c.phoneCode,
            flag: c.flag,
            currency: c.currency,
            latitude: c.latitude,
            longitude: c.longitude,
          ))
      .toList();
}
