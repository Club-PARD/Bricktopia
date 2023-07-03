import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homepage/home/homepage.dart';

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
      home: const HomePage(),
    );
  }
}
