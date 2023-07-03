import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:homepage/home/homepage.dart';
import 'package:page_transition/page_transition.dart';

import 'chatbot/constants/themes.dart';
import 'home/pages/tts.dart';
import 'home/pages/weather.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset('assets/weatherlook_logo.png'),
        splashIconSize: 362,
        nextScreen: const HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.white,
      ),
      routes: {
        '/tts': (BuildContext context) => const TextToSpeech(),
        '/weather': (BuildContext context) => const WeatherPage(),
      },
    );
  }
}