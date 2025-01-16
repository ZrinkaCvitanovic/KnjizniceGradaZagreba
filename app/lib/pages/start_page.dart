import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_library_fe/controller/cars_data_download.dart';

final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String? accessToken;
  String? userProfile;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _setupTokenListener();
  }

  Future<void> _checkLoginStatus() async {
    String? token = await secureStorage.read(key: 'accessToken');
    if (token != null) {
      setState(() {
        accessToken = token;
      });
      await _fetchUserProfile();
    }
  }

  void _setupTokenListener() {
    html.window.onMessage.listen((event) {
      final token = event.data;
      if (token != null) {
        secureStorage.write(key: 'accessToken', value: token);
        setState(() {
          accessToken = token;
        });
        _fetchUserProfile();
      }
    });
  }

  Future<void> _fetchUserProfile() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/profile'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      setState(() {
        userProfile = response.body;
      });
    } else {
      setState(() {
        userProfile = 'Failed to fetch user profile';
      });
    }
  }

  Future<void> _logout() async {
    await secureStorage.delete(key: 'accessToken');
    setState(() {
      accessToken = null;
      userProfile = null;
    });
    html.window.open('http://localhost:8080/logout', '_self');
  }

  @override
  Widget build(BuildContext context) {
    // Postavljanje meta podataka
    html.document.title = 'Start page';
    html.MetaElement description = html.MetaElement();
    description.name = 'Zrinka Cvitanović';
    description.content = 'Pocetna stranica';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Dobro došli!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40),
            accessToken == null
                ? ElevatedButton(
                    onPressed: () {
                      html.window.open('http://localhost:8080/login', '_blank');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Merriweather',
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 120),
                    ),
                    child: Text('Prijava'),
                  )
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          html.window
                              .open('http://localhost:8080/profile', '_self');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Merriweather',
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 120),
                        ),
                        child: Text('Profil'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _logout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Merriweather',
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 120),
                        ),
                        child: Text('Odjava'),
                      ),
                      SizedBox(height: 20),
                      RefreshButton(),
                    ],
                  ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
