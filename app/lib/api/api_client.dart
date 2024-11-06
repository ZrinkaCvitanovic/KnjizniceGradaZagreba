import 'package:dio/dio.dart';
import 'package:web_library_fe/model/library.dart';

class ApiClient {
  late final Dio _httpClient;

  ApiClient() {
    _httpClient = Dio();
  }

  Future<List<Library>> getLibraries() async {
    final response = await _httpClient.get("http://localhost:3000/libraries");
    return (response.data as List<dynamic>)
        .map((element) => Library.fromJson(element as Map<String, dynamic>))
        .toList();
  }
}
