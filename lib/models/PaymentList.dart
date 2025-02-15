import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reis_imovel_app/dto/Payment.dart';
import 'package:reis_imovel_app/enums.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';

class PaymentList with ChangeNotifier {
  final String _token;

  final String _userId;

  Payment? _currentPayment;

  final dio = Dio();

  Payment? get currentPayment => _currentPayment;

  PaymentList([
    this._token = '',
    this._userId = '',
    this._currentPayment,
  ]);

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

  Future<void> createSchedulingPayment(
    String propertyId,
    String schedulingId,
  ) async {
    const url = "${AppConstants.baseUrl}scheduling-payments/";

    final formattedData = {
      'userId': _userId,
      'propertyId': propertyId,
      'schedulingId': schedulingId,
      'totalValue': AppConstants.visitFee,
      'paymentMethod': PaymentMethod.MULTICAIXA_EXPRESS.name,
      'reference': AppUtils.generateRandomReference()
    };

    debugPrint('--------------------');
    debugPrint('$formattedData ');
    debugPrint('--------------------');

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
    } on DioException catch (e) {
      debugPrint('####################');
      debugPrint('ERRO NO PAGAMENTO');
      if (e.response != null) {
        debugPrint('Erro no servidor: ${e.response?.data}');
      } else {
        debugPrint('Erro desconhecido: ${e.message}');
      }
      debugPrint('####################');

      throw Exception('Ocorreu erro ao criar o pagamento: ' + e.toString())
          .toString();
    }
  }
}
