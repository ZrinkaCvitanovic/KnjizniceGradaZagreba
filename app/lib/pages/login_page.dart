import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:web_library_fe/pages/home_page.dart';
import 'package:web_library_fe/pages/start_page.dart';
import 'package:universal_html/html.dart' as html;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    html.document.title = 'Login page';
    html.MetaElement description = html.MetaElement();
    description.name = 'Zrinka Cvitanović';
    description.content = 'Login stranica';
    html.document.head?.append(description);
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
