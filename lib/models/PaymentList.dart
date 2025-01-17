import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reis_imovel_app/dto/Payment.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';

class PaymentList with ChangeNotifier {
  final String _token;

  Payment? _currentPayment;

  final dio = Dio();

  Payment? get currentPayment => _currentPayment;

  PaymentList([this._token = '', this._currentPayment]);

  Future<void> loadPaymentByReference(String reference) async {
    final url =
        "${AppConstants.baseUrl}payments/by-reference?reference=$reference";

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
        _currentPayment = Payment.fromJSON(response.data);
      }
    } catch (e) {
      throw Exception('Ocorreu erro ao buscar o pagamento por referencia: ' +
              e.toString())
          .toString();
    }
  }

  Future<void> createPayment(
      String reference, double totalValue, String paymentMethod) async {
    const url = "${AppConstants.baseUrl}payments/";

    final formattedData = {
      'reference': reference,
      "totalValue": totalValue,
      "paymentMethod": paymentMethod
    };

    try {
      final response = await dio.post(
        url,
        data: formattedData,
        options: Options(
          headers: {"Authorization": "Bearer $_token"},
          contentType: Headers.jsonContentType, //'application/json'
          responseType: ResponseType.json,
        ),
      );

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu erro ao criar o pagamento: ' + e.toString())
          .toString();
    }
  }
}
