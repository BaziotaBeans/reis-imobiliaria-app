import 'package:flutter/material.dart';

class Property with ChangeNotifier {
  final String? pkProperty;

  final String title;

  final String province;

  final String county;

  final String? address;

  final int? suits;

  final int? room;

  final int? bathroom;

  final int? vacancy;

  final double? price;

  final double? totalArea;

  final double? buildingArea;

  final String? description;

  final String? paymentModality;

  final bool status;

  final String fkCompany;

  final String fkPropertyType;

  final double? latitude;

  final double? longitude;

  final List<String> images;

  Property({
    this.pkProperty,
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
    required this.fkCompany,
    required this.fkPropertyType,
    required this.images,
    required this.latitude,
    required this.longitude,
  });
}
