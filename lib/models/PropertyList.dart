import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/dto/PropertyTypeEntity.dart';
import 'package:reis_imovel_app/models/Property.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';

class PropertyList with ChangeNotifier {
  final String _token;
  final String _userId;
  List<PropertyResult> _propertiesCompany = [];
  List<PropertyResult> _propertiesPublic = [];
  List<PropertyTypeEntity> _propertyTypes = [];

  final dio = Dio();

  List<PropertyResult> get propertiesCompany => [..._propertiesCompany];

  List<PropertyResult> get propertiesPublic => [..._propertiesPublic];

  List<PropertyTypeEntity> get propertyTypes => [..._propertyTypes];

  PropertyList([
    this._token = '',
    this._userId = '',
    this._propertiesCompany = const <PropertyResult>[],
    this._propertiesPublic = const <PropertyResult>[],
    this._propertyTypes = const <PropertyTypeEntity>[],
  ]);

  Future<void> saveProperty(Map<String, Object> data) {
    bool hasId = data['pkProperty'] != null;

    final formData = jsonEncode({
      'title': data['title'],
      'province': data['province'],
      'county': data['county'],
      'address': data['address'],
      'suits': data['suits'],
      'room': data['room'],
      'bathroom': data['bathroom'],
      'vacancy': data['vacancy'],
      'price': data['price'],
      'totalArea': data['totalArea'],
      'description': data['description'],
      'paymentModality': data['paymentModality'],
      'status': true,
      'fkCompany': _userId,
      'fkPropertyType': data['fkPropertyType'],
      'images': data['images'] as List<String>,
      'propertyStatus': data['propertyStatus'],
      'schedules': data['schedules'],
      'latitude': data['latitude'] as double,
      'longitude': data['longitude'] as double,
    });

    final property = Property(
      title: data['title'] as String,
      province: data['province'] as String,
      county: data['county'] as String,
      address: data['address'] as String,
      suits: data['suits'] as int,
      room: data['room'] as int,
      bathroom: data['bathroom'] as int,
      vacancy: data['vacancy'] as int,
      price: data['price'] as double,
      totalArea: data['totalArea'] as double,
      buildingArea: data['buildingArea'] as double,
      description: data['description'] as String,
      paymentModality: data['paymentModality'] as String,
      status: true,
      fkCompany: _userId,
      fkPropertyType: data['fkPropertyType'] as String,
      images: data['images'] as List<String>,
      latitude: data['latitude'] as double,
      longitude: data['longitude'] as double,
    );

    if (hasId) {
      return updateProperty(property);
    } else {
      return addProperty(formData);
    }
  }

  Future<void> addProperty(String data) async {
    const url = '${AppConstants.baseUrl}property/';

    final response = await dio.post(
      url,
      data: data,
      options: Options(
        headers: {"Authorization": "Bearer $_token"},
        contentType: Headers.jsonContentType, //'application/json'
        responseType: ResponseType.json,
      ),
    );

    notifyListeners();
  }

  Future<void> updateProperty(Property property) async {
    // int index = _propertiesCompany.indexWhere((p) => p.pkProperty == property.pkProperty);

    // if (index >= 0) {}

    notifyListeners();
  }

  Future<void> loadPublicProperties() async {
    _propertiesPublic.clear();

    const url = "${AppConstants.baseUrl}property/with-status-true";

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {"Authorization": "Bearer $_token"},
          contentType: Headers.jsonContentType, //'application/json'
          responseType: ResponseType.json,
        ),
      );

      List<dynamic> jsonData = response.data;

      _propertiesPublic =
          jsonData.map((data) => PropertyResult.fromJson(data)).toList();

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu um erro ao pesquisar os dados: ' + e.toString())
          .toString();
    }
  }

  Future<void> loadCompanyProperties() async {
    _propertiesCompany.clear();

    final url = "${AppConstants.baseUrl}property/company/$_userId";

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {"Authorization": "Bearer $_token"},
          contentType: Headers.jsonContentType, //'application/json'
          responseType: ResponseType.json,
        ),
      );

      if (response.data.toString().isEmpty) {
        _propertiesCompany = [];
      } else {
        List<dynamic> jsonData = response.data;

        _propertiesCompany =
            jsonData.map((data) => PropertyResult.fromJson(data)).toList();
      }

      // _propertiesCompany = response.data;

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu um erro ao processar os dados: ' + e.toString())
          .toString();
    }
  }

  Future<void> deleteProperty(String pkProperty) async {
    _propertiesCompany.clear();

    final url = "${AppConstants.baseUrl}property/$pkProperty";

    try {
      await dio.delete(
        url,
        options: Options(
          headers: {"Authorization": "Bearer $_token"},
          contentType: Headers.jsonContentType, //'application/json'
          responseType: ResponseType.json,
        ),
      );
    } catch (e) {
      throw Exception('Ocorreu um erro ao processar os dados: ' + e.toString())
          .toString();
    }
  }

  Future<void> loadPropertyTypes() async {
    _propertyTypes.clear();

    const url = "${AppConstants.baseUrl}property-type/";

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {"Authorization": "Bearer $_token"},
          contentType: Headers.jsonContentType, //'application/json'
          responseType: ResponseType.json,
        ),
      );

      print(response.data);

      List<dynamic> jsonData = response.data;

      _propertyTypes =
          jsonData.map((data) => PropertyTypeEntity.fromJson(data)).toList();

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu um erro ao pesquisar os dados: ' + e.toString())
          .toString();
    }
  }
}
