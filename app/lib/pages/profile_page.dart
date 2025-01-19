import 'package:web_library_fe/model/user.dart';
import 'package:flutter/material.dart';
import 'package:web_library_fe/service/data_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ApiResponse> _profileFuture;
  final DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();
    _profileFuture = _dataService.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder<ApiResponse>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final apiResponse = snapshot.data!;
            if (apiResponse.status == "success") {
              final user = apiResponse.data!;
              return Center(child: Text('Welcome, ${user.nickname}!'));
            } else {
              return Center(child: Text('Error: ${apiResponse.message}'));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
