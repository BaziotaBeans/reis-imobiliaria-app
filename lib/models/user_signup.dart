class UserSignup {
  final String username;
  final String fullName;
  final String email;
  final String password;
  final String phone;
  final List<String> role;
  final String nif;
  final String address;
  final String nationality;
  final String maritalStatus;
  final String urlDocument;

  UserSignup({
    required this.username,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    required this.nif,
    required this.address,
    required this.nationality,
    required this.maritalStatus,
    required this.urlDocument,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'fullName': fullName,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role,
      'nif': nif,
      'address': address,
      'nationality': nationality,
      'maritalStatus': maritalStatus,
      'urlDocument': urlDocument,
    };
  }
}
