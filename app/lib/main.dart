import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_library_fe/pages/start_page.dart';

void main() async => runApp(ProviderScope(child: const MainApp()));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Merriweather',
        colorSchemeSeed: Colors.blue,
      ),
      home: const StartPage(),
    );
  }
}
