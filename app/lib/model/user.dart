class User {
  final String name;
  final String nickname;
  final String updatedAt;

  User({required this.name, required this.nickname, required this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'] ?? '',
        nickname: json['nickname'] ?? '',
        updatedAt: json['updated_at'] ?? '');
  }
}

class ApiResponse {
  final String status;
  final String? message;
  final User? data;

  ApiResponse({required this.status, this.message, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      message: json['message'],
      data: json != null ? User.fromJson(json) : null,
    );
  }
}
