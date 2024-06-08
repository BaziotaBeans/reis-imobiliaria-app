class Role {
  final String pkRole;
  final String name;

  Role({
    required this.pkRole,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      pkRole: json['pkRole'],
      name: json['name'],
    );
  }
}
