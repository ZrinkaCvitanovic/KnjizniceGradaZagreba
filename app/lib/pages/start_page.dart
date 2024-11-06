import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:web_library_fe/pages/home_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 80,
                    horizontal: 150,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.9),
                        Colors.white.withOpacity(0.5),
                      ],
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white.withOpacity(0.75),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Dobro došli!',
                        style: TextStyle(
                          fontSize: 64,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Pretražite knjižnice, saznajte sve potrebne informacije.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 60),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Merriweather',
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 120),
                        ),
                        onPressed: () => _redirectToHomePage(context),
                        child: const Text('Pretraga'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _redirectToHomePage(final BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }
}
