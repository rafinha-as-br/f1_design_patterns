import 'package:flutter/material.dart';

import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const F1DesignPatternsApp());
}

class F1DesignPatternsApp extends StatelessWidget {
  const F1DesignPatternsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F1 Design Patterns',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE10600), // F1 red
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
