import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reis_imovel_app/dto/Order.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';

class OrderList with ChangeNotifier {
  final String _token;

  final String _userId;

  Order? _currentOrder;

  List<Order> _ordersByUser = [];

  Order? get currentOrder => _currentOrder;

  List<Order> get ordersByUser => [..._ordersByUser];

  final dio = Dio();

  OrderList([
    this._token = '',
    this._userId = '',
    this._currentOrder,
    this._ordersByUser = const <Order>[],
  ]);

  Future<void> loadOrdersByUser() async {
    _ordersByUser.clear();

    final url = "${AppConstants.baseUrl}orders/user/$_userId";

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

        _ordersByUser = jsonData.map((data) => Order.fromJSON(data)).toList();
      }

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu um erro ao processar os dados: ' + e.toString())
          .toString();
    }
  }

  Future<void> loadLastOrder() async {
    const url = "${AppConstants.baseUrl}orders/last";

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
        _currentOrder = Order.fromJSON(response.data);
      }
    } catch (e) {
      throw Exception('Ocorreu erro ao buscar o ultimo pedido: ' + e.toString())
          .toString();
    }
  }

  Future<void> createOrder(
      String pkProperty, double totalValue, String paymentMethod) async {
    const url = "${AppConstants.baseUrl}orders/";

    final formattedData = {
      'userId': _userId,
      'propertyId': pkProperty,
      "entidade": "00750",
      "totalValue": totalValue,
      "paymentMethod": paymentMethod
    };

    try {
      await dio.post(
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
      throw Exception('Ocorreu ao erro criar o pedido: ' + e.toString())
          .toString();
    }
  }

  Future<void> deleteOrder(String pkOrder) async {
    final url = "${AppConstants.baseUrl}orders/$pkOrder";

    try {
      await dio.delete(
        url,
        options: Options(
          headers: {"Authorization": "Bearer $_token"},
          contentType: Headers.jsonContentType, //'application/json'
          responseType: ResponseType.json,
        ),
      );

      notifyListeners();
    } catch (e) {
      throw Exception('Ocorreu ao erro remover o pedido: ' + e.toString())
          .toString();
    }
  }
}
