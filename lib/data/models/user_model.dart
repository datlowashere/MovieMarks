class UserModel {
  final String? id;
  final String email;
  final String? fullName;
  final String? username;
  final String password;
  final String? accessToken;
  final String? avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? code;

  UserModel({
    this.id,
    required this.email,
    this.fullName,
    this.username,
    required this.password,
    this.accessToken,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.code,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? username,
    String? password,
    String? accessToken,
    String? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? code,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      password: password ?? this.password,
      accessToken: accessToken ?? this.accessToken,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      code: code ?? this.code,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] != null ? json['_id'] as String : "",
      email: json['email'] != null ? json['email'] as String : "",
      fullName: json['fullName'] != null ? json['fullName'] as String : "",
      username: json['username'] != null ? json['username'] as String : "",
      password: json['password'] != null ? json['password'] as String : "",
      accessToken:
          json['accessToken'] != null ? json['accessToken'] as String : "",
      avatar: json['avatar'] != null ? json['avatar'] as String : "",
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      code: json['code'] != null ? json['code'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'fullName': fullName,
      'username': username,
      'password': password,
      'accessToken': accessToken,
      'avatar': avatar,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'code': code,
    };
  }

  Map<String, dynamic> loginToJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  Map<String, dynamic> registerToJson() {
    return {'email': email, 'password': password, 'code': code};
  }
}
