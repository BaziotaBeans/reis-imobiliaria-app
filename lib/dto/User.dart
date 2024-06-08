import 'package:reis_imovel_app/dto/Role.dart';

class User {
  final String pkUser;
  final String username;
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final List<Role> roles;
  final String nif;
  final String address;
  final String nationality;
  final String maritalStatus;
  // O campo 'hibernateLazyInitializer' é ignorado na deserialização

  User({
    required this.pkUser,
    required this.username,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.roles,
    required this.nif,
    required this.address,
    required this.nationality,
    required this.maritalStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      pkUser: json['pkUser'],
      username: json['username'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      roles: (json['roles'] as List).map((r) => Role.fromJson(r)).toList(),
      nif: json['nif'],
      address: json['address'],
      nationality: json['nationality'],
      maritalStatus: json['maritalStatus'],
    );
  }
}
