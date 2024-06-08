class PropertyTypeEntity {
  final String pkPropertyType;
  final String designation;
  // O campo 'hibernateLazyInitializer' é ignorado na deserialização

  PropertyTypeEntity({
    required this.pkPropertyType,
    required this.designation,
  });

  factory PropertyTypeEntity.fromJson(Map<String, dynamic> json) {
    return PropertyTypeEntity(
      pkPropertyType: json['pkPropertyType'],
      designation: json['designation'],
    );
  }
}
