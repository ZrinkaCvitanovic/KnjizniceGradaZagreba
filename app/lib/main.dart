import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_library_fe/pages/start_page.dart';
import 'package:web_library_fe/pages/home_page.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const StartPage(),
        '/datatable': (context) => const HomePage(),
      },
      builder: (context, child) {
        return Scaffold(
          body: child,
        );
      },
    );
  }
}
