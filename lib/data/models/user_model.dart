// lib/data/models/user_model.dart
class UserModel {
  final String id;
  final String username;
  final String email;
  final String? avatar;
  final String? phone;
  final String? nickname;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    this.phone,
    this.nickname,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      nickname: json['nickname'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'phone': phone,
      'nickname': nickname,
    };
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? avatar,
    String? phone,
    String? nickname,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      nickname: nickname ?? this.nickname,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, avatar: $avatar, phone: $phone, nickname: $nickname)';
  }
}
