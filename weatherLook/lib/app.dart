import 'package:flutter/material.dart';
import 'package:homepage/home/homepage.dart';
import 'package:homepage/screens/weather.dart';

import 'chatbot/constants/themes.dart';

class WeatherLook extends StatelessWidget {
  const WeatherLook({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (BuildContext context) => const HomePage(),
        //'/tts': (BuildContext context) => const TextToSpeech(),
        '/weather': (BuildContext context) => const WeatherPage(),
      },
    );
  }
}
