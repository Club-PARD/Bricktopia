import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'chatbot/constants/themes.dart';
import 'home/pages/tts.dart';
import 'home/pages/weather.dart';
import 'home/screen_pages/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/tts': (BuildContext context) => const TextToSpeech(),
        '/weather': (BuildContext context) => const WeatherPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  // double videoAspectRatio = (MediaQuery.of(context).size.width) /
  //               (MediaQuery.of(context).size.height) ;
  // double videoAspectRatio = 9 / 16;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/splash.mp4')
      ..initialize().then((_) {
        _controller.play();
        Future.delayed(const Duration(seconds: 3), () {
          _controller.pause();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
          );
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double videoAspectRatio = (MediaQuery.of(context).size.width) /
        (MediaQuery.of(context).size.height);
    return Scaffold(
      body: Container(
        color: Colors.white, // 흰 배경

        child: Center(
          child: AspectRatio(
            aspectRatio: videoAspectRatio,
            child: VideoPlayer(_controller),
          ),
        ),
      ),
    );
  }
}
