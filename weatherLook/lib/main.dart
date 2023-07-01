import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homepage/home/homepage.dart';
import 'package:page_transition/page_transition.dart';

import 'chatbot/constants/themes.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final activeTheme = ref.watch(activeThemeProvider);
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
    );
  }
}
