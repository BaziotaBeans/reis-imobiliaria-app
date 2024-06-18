class UserUpdate {
  final String username;
  final String fullName;
  final String email;
  final String phone;
  final String nif;
  final String address;
  final String nationality;
  final String maritalStatus;

  UserUpdate({
    required this.username,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.nif,
    required this.address,
    required this.nationality,
    required this.maritalStatus,
  });

  factory UserUpdate.fromJson(Map<String, dynamic> json) {
    return UserUpdate(
      username: json['username'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      nif: json['nif'],
      address: json['address'],
      nationality: json['nationality'],
      maritalStatus: json['maritalStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'nif': nif,
      'address': address,
      'nationality': nationality,
      'maritalStatus': maritalStatus,
    };
  }
}
