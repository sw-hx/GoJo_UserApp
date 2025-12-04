class UserModel {
  final String id;
  final String personFullName;
  final String email;
  final String username;
  String? profilePhoto;
  final String password;

  UserModel({
    required this.id,
    required this.personFullName,
    required this.email,
    required this.username,
    required this.profilePhoto,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': personFullName,
      'email': email,
      'username': username,
      'profilePhoto': profilePhoto,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    String safeId;
    if (map['id'] == null) {
      safeId = '';
    } else if (map['id'] is int) {
      safeId = (map['id'] as int).toString();
    } else if (map['id'] is String) {
      safeId = map['id'];
    } else {
      safeId = map['id'].toString();
    }

    return UserModel(
      id: safeId,
      personFullName: map['name'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      profilePhoto: map['profilePhoto'],
      password: map['password'] ?? '',
    );
  }
}
