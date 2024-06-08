import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reis_imovel_app/dto/Scheduling.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';

class SchedulingList with ChangeNotifier {
  final String _token;

  final String _userId;

  List<Scheduling> _schedulingsByUser = [];

  List<Scheduling> _schedulingsByCompany = [];

  List<Scheduling> get schedulingsByUser => [..._schedulingsByUser];

  List<Scheduling> get schedulingsByCompany => [..._schedulingsByCompany];

  final dio = Dio();

  SchedulingList([
    this._token = '',
    this._userId = '',
    this._schedulingsByUser = const <Scheduling>[],
    this._schedulingsByCompany = const <Scheduling>[],
  ]);

  Future<void> loadSchedulingByCompany() async {
    _schedulingsByCompany.clear();

    final url = "${AppConstants.baseUrl}scheduling/findByCompany/$_userId";

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

        _schedulingsByCompany =
            jsonData.map((data) => Scheduling.fromJSON(data)).toList();
      }

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu um erro ao pesquisar os dados: ' + e.toString())
          .toString();
    }
  }

  Future<void> loadSchedulingsByUser() async {
    _schedulingsByUser.clear();

    final url = "${AppConstants.baseUrl}scheduling/findByUserId/$_userId";

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

        _schedulingsByUser =
            jsonData.map((data) => Scheduling.fromJSON(data)).toList();
      }

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu um erro ao pesquisar os dados: ' + e.toString())
          .toString();
    }
  }

  Future<void> deleteScheduling(String pkScheduling) async {
    int index =
        _schedulingsByUser.indexWhere((p) => p.pkScheduling == pkScheduling);

    final url = "${AppConstants.baseUrl}scheduling/$pkScheduling";

    try {
      await dio.delete(
        url,
        options: Options(
          headers: {"Authorization": "Bearer $_token"},
          contentType: Headers.jsonContentType, //'application/json'
          responseType: ResponseType.json,
        ),
      );

      if (index >= 0) {
        final scheduling = _schedulingsByUser[index];
        _schedulingsByUser.remove(scheduling);
        notifyListeners();
      }

      await loadSchedulingsByUser();

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu um erro ao processar os dados: ' + e.toString())
          .toString();
    }
  }
}
