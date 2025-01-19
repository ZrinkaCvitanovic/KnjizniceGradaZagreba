import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_library_fe/model/user.dart';

class DataService {
  Future<ApiResponse> fetchUserProfile() async {
    final response = await http.get(Uri.parse('/profile'));

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
