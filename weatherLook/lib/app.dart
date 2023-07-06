import 'package:flutter/material.dart';
import 'package:weather_summary/pages/home/main_page.dart';
import 'package:weather_summary/pages/item_page.dart';
import 'package:weather_summary/pages/weather.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
      routes: {
        '/item': (BuildContext context) => const ItemPage(),
        '/weather': (BuildContext context) => const WeatherPage(),
      },
    );
  }
}
