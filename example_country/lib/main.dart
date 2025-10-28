import 'package:example_country/country_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example Country App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: CountryApp(),
      ),
    );
  }
}

class CountryApp extends StatefulWidget {
  const CountryApp({super.key});

  @override
  State<CountryApp> createState() => _CountryAppState();
}

class _CountryAppState extends State<CountryApp> {
  @override
  Widget build(BuildContext context) {
    return const CountryView();
  }
}
