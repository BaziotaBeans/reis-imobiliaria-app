import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static final navigationKey = GlobalKey<NavigatorState>();

  static final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.([a-zA-Z]{2,})+",
  );

  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#!%*?&_])[A-Za-z\d@#$!%*?&_].{7,}$',
  );

  static const double selectUserTypeGapBetweenBox = 24;

  static const double screenHorizontalPadding = 30;

  static const double screenPadding = 24;

  // static const baseUrl = "http://localhost:8080/api/";

  // static const baseUrl = "http://192.168.0.204/api/";

  // static const machineIP = "172.20.10.5";

  static const machineIP = "192.168.0.224";

  static const baseUrl = "http://10.0.2.2:8080/api/";

  // static const baseUrl = "http://$machineIP:8080/api/";

  static const baseUrlAndroid = "http://10.0.2.2:8080/api/";

  static const propertyType = [
    // Arrendamento
    '96555908-efa4-4c30-ae8d-0ebe74d2e647',
    // Venda
    '59840257-9c7d-4879-b4d1-af078fc7190e',
    // Casa
    '5f9a2248-f24c-4994-823f-5a84f461a779',
    // Vivenda
    'a7fbf435-f7c7-4173-b7e0-557df4d7d427',
    // Terreno
    '2605ee1f-b855-4da4-bebb-97d9bec5cc06'
  ];

  static const propertyTypeSale =
      '59840257-9c7d-4879-b4d1-af078fc7190e'; //venda

  static const propertyTypeRent =
      '96555908-efa4-4c30-ae8d-0ebe74d2e647'; //Aluguel

  static const propertyTypeGround = '2605ee1f-b855-4da4-bebb-97d9bec5cc06';

  static const Duration kDefaultDuration = Duration(milliseconds: 250);

  static const double defaultPadding = 16;

  static const PROPERTY_STATUS = {
    'rentend': 'RENTED',
    'standby': 'STANDBY',
    'published': 'PUBLISHED'
  };

  // static const baseUrl = "http://192.168.0.204:8080/api/";
}
