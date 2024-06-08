import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';

class ContractList with ChangeNotifier {
  final String _token;
  final String _userId;
  List<Contract> _contracts = [];
  List<Contract> _contractsByCompany = [];

  final dio = Dio();

  List<Contract> get contracts => [..._contracts];

  List<Contract> get contractsByCompany => [..._contractsByCompany];

  ContractList([
    this._token = '',
    this._userId = '',
    this._contracts = const <Contract>[],
    this._contractsByCompany = const <Contract>[],
  ]);

  Future<void> loadContractsByCompany() async {
    _contractsByCompany.clear();

    final url = "${AppConstants.baseUrl}contracts/company/$_userId";

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

        _contractsByCompany =
            jsonData.map((data) => Contract.fromJSON(data)).toList();
      }

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu um erro ao pesquisar os dados: ' + e.toString())
          .toString();
    }
  }

  Future<void> loadContracts() async {
    _contracts.clear();

    final url = "${AppConstants.baseUrl}contracts/user/$_userId";

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

        _contracts = jsonData.map((data) => Contract.fromJSON(data)).toList();
      }

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu um erro ao pesquisar os dados: ' + e.toString())
          .toString();
    }
  }
}
