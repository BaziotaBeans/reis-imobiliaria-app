import 'package:reis_imovel_app/dto/CompanyEntity.dart';
import 'package:reis_imovel_app/dto/PropertyTypeEntity.dart';

class Property {
  final String pkProperty;
  final String title;
  final String province;
  final String county;
  final String address;
  final int suits;
  final int room;
  final int bathroom;
  final int vacancy;
  final double price;
  final double totalArea;
  final double buildingArea;
  final String description;
  final String paymentModality;
  final bool status;
  final CompanyEntity companyEntity;
  final String fkCompany;
  final PropertyTypeEntity fkPropertyTypeEntity;
  final String fkPropertyType;
  final List<dynamic> propertyImages; // Tipicamente, seria uma lista de uma classe Image, se necessário
  final String propertyStatus;
  final List<dynamic> schedules; // Tipicamente, seria uma lista de uma classe Schedule, se necessário
  final String createdAt;

  Property({
    required this.pkProperty,
    required this.title,
    required this.province,
    required this.county,
    required this.address,
    required this.suits,
    required this.room,
    required this.bathroom,
    required this.vacancy,
    required this.price,
    required this.totalArea,
    required this.buildingArea,
    required this.description,
    required this.paymentModality,
    required this.status,
    required this.companyEntity,
    required this.fkCompany,
    required this.fkPropertyTypeEntity,
    required this.fkPropertyType,
    required this.propertyImages,
    required this.propertyStatus,
    required this.schedules,
    required this.createdAt,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      pkProperty: json['pkProperty'],
      title: json['title'],
      province: json['province'],
      county: json['county'],
      address: json['address'],
      suits: json['suits'],
      room: json['room'],
      bathroom: json['bathroom'],
      vacancy: json['vacancy'],
      price: json['price'].toDouble(),
      totalArea: json['totalArea'].toDouble(),
      buildingArea: json['buildingArea'].toDouble(),
      description: json['description'],
      paymentModality: json['paymentModality'],
      status: json['status'],
      companyEntity: CompanyEntity.fromJson(json['companyEntity']),
      fkCompany: json['fkCompany'],
      fkPropertyTypeEntity: PropertyTypeEntity.fromJson(json['fkPropertyTypeEntity']),
      fkPropertyType: json['fkPropertyType'],
      propertyImages: json['propertyImages'],
      propertyStatus: json['propertyStatus'],
      schedules: json['schedules'],
      createdAt: json['createdAt'],
    );
  }
}
