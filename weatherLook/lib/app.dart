import 'package:flutter/material.dart';
import 'package:weather_summary/chatbot/constants/themes.dart';
import 'package:weather_summary/pages/splash.dart';
import 'package:weather_summary/pages/weather.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/weather': (BuildContext context) => const WeatherPage(),
      },
    );
  }
}
