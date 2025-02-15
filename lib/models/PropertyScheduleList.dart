import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:reis_imovel_app/dto/PropertyScheduleResult.dart';
import 'package:reis_imovel_app/dto/Scheduling.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';

class PropertyScheduleList with ChangeNotifier {
  final String _token;
  // final String _userId;
  List<PropertyScheduleResult> _propertiesSchedules = [];

  List<PropertyScheduleResult> _propertiesAvailableSchedules = [];

  Scheduling? _currentScheduling;

  Scheduling? get currentScheduling => _currentScheduling;

  List<PropertyScheduleResult> get propertiesSchedule =>
      [..._propertiesSchedules];

  List<PropertyScheduleResult> get propertiesAvailableSchedules =>
      [..._propertiesAvailableSchedules];

  final dio = Dio();

  PropertyScheduleList([
    this._token = '',
    // this._userId = '',
    this._currentScheduling,
    this._propertiesSchedules = const <PropertyScheduleResult>[],
    this._propertiesAvailableSchedules = const <PropertyScheduleResult>[],
  ]);

  Future<void> createScheduling(
      String pkPropertySchedule, String pkProperty) async {
    final url =
        '${AppConstants.baseUrl}scheduling/${pkPropertySchedule}/${pkProperty}';

    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {"Authorization": "Bearer $_token"},
          contentType: Headers.jsonContentType, //'application/json'
          responseType: ResponseType.json,
        ),
      );

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu um erro ao criar o agendamento: ' + e.toString())
          .toString();
    }
  }

  Future<void> loadLastScheduling() async {
    const url = "${AppConstants.baseUrl}scheduling/last";

    try {
      final response = await dio.get(url,
          options: Options(
            headers: {"Authorization": "Bearer $_token"},
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));

      if (response.data.toString().isNotEmpty) {
        _currentScheduling = Scheduling.fromJSON(response.data);
      }

      notifyListeners();
    } catch (e) {
      throw Exception(
              'Ocorreu um erro ao carregar o agendamento: ' + e.toString())
          .toString();
    }
  }

  Future<void> findSchedulesByPropertyId(String pkProperty) async {
    _propertiesSchedules.clear();

    final url = "${AppConstants.baseUrl}property/schedule/$pkProperty";

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {"Authorization": "Bearer $_token"},
          contentType: Headers.jsonContentType, //'application/json'
          responseType: ResponseType.json,
        ),
      );

      if (response.data.toString().isNotEmpty) {
        List<dynamic> jsonData = response.data;

        _propertiesSchedules = jsonData
            .map((data) => PropertyScheduleResult.fromJson(data))
            .toList();
      }

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu um erro ao pesquisar os dados: ' + e.toString())
          .toString();
    }
  }

  Future<void> findAvailableSchedulesByPropertyId(String pkProperty) async {
    _propertiesAvailableSchedules.clear();

    final url =
        "${AppConstants.baseUrl}property/schedule/available/$pkProperty";

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
        _propertiesAvailableSchedules = <PropertyScheduleResult>[];
      } else {
        List<dynamic> jsonData = response.data;

        _propertiesAvailableSchedules = jsonData
            .map((data) => PropertyScheduleResult.fromJson(data))
            .toList();
      }

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu um erro ao pesquisar os dados: ' + e.toString())
          .toString();
    }
  }
}
