import 'package:example_country/cities.dart';
import 'package:flutter/material.dart';
import 'package:fy_country_state_city/fy_country_state_city.dart' as fy;

class StateView extends StatelessWidget {
  final String countryCode;
  const StateView({super.key, required this.countryCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('States of $countryCode')),
      body: FutureBuilder<List<fy.State>>(
        future: fetchStates(countryCode),
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
                      builder: (context) => CitiesView(
                        stateCode: snapshot.data?[index].isoCode ?? '',
                        countryCode: countryCode,
                      ),
                    ),
                  );
                },
                child: ListTile(title: Text(snapshot.data?[index].name ?? '')),
              );
            },
          );
        },
      ),
    );
  }
}

Future<List<fy.State>> fetchStates(String countryCode) async {
  final List<fy.State> cscStates = await fy.getStatesOfCountry(countryCode);
  return cscStates
      .map((s) => fy.State(
            name: s.name,
            isoCode: s.isoCode,
            countryCode: s.countryCode,
          ))
      .toList();
}
