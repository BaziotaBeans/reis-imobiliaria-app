import 'dart:async';

import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:reis_imovel_app/components/user_update_form.dart';
import 'package:reis_imovel_app/data/store.dart';
import 'package:reis_imovel_app/dto/ChangePassword.dart';
import 'package:reis_imovel_app/dto/UserUpdate.dart';
import 'package:reis_imovel_app/models/Client.dart';
import 'package:reis_imovel_app/models/Company.dart';
import 'package:reis_imovel_app/models/user_signup.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _phone;
  String? _userId;
  String? _userName;
  String? _fullName;
  String? _address;
  String? _nif;
  String? _nationality;
  String? _maritalStatus;
  DateTime? _expiryDate;
  Timer? _logoutTimer;

  List<dynamic> _roles = [];
  final dio = Dio();
  // DateTime? _expiryDate;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get phone {
    return isAuth ? _phone : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  String? get userName {
    return isAuth ? _userName : null;
  }

  List? get roles {
    return isAuth ? _roles : null;
  }

  String? get fullName {
    return isAuth ? _fullName : null;
  }

  String? get address {
    return isAuth ? _address : null;
  }

  String? get nif {
    return isAuth ? _nif : null;
  }

  String? get nationality {
    return isAuth ? _nationality : null;
  }

  String? get maritalStatus {
    return isAuth ? _maritalStatus : null;
  }

  Future<void> login(String userName, String password) async {
    const url = '${AppConstants.baseUrl}auth/signin';

    try {
      final response = await dio.post(url, data: {
        'username': userName,
        'password': password,
      });

      final body = response.data;

      if (body['error'] != null) {
        throw Exception(
            'Ocorreu um erro no processo de autenticação: ${body['error']}');
      } else {
        _token = body['accessToken'];
        _email = body['email'];
        _phone = body['phone'];
        _userId = body['pkUser'];
        _roles = body['roles'];
        _userName = body['username'];
        _fullName = body['fullName'];
        _address = body['address'];
        _nif = body['nif'];
        _nationality = body['nationality'];
        _maritalStatus = body['maritalStatus'];
        _expiryDate = DateTime.parse(body['expirationDate']);

        Store.saveMap('userData', {
          'token': _token,
          'email': _email,
          'userId': _userId,
          'username': _userName,
          'fullName': _fullName,
          'address': _address,
          'nif': _nif,
          'nationality': _nationality,
          'maritalStatus': _maritalStatus,
          'expiryDate': _expiryDate
        });

        _autoLogout();
        notifyListeners();
        // print(isAuth);
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Ocorreu um erro no processo de autenticação.');
    }
  }

  Future<void> signup(
    String username,
    String email,
    String password,
    String phone,
    List<String> role,
  ) async {
    const url = '${AppConstants.baseUrl}auth/signup';

    final response = await dio.post(
      url,
      data: {
        'username': username,
        "email": email,
        "phone": phone,
        'password': password,
        "role": role
      },
    );

    final body = response.data;

    if (body['error'] != null) {
      throw Exception('Ocorreu um erro no processo de autenticação.: ${body}');
    } else {
      notifyListeners();
    }
  }

  Future<void> signupWithCompany(UserSignup user, Company company) async {
    const url = '${AppConstants.baseUrl}auth/signup';

    try {
      final response = await dio.post(url, data: user.toJson());

      final body = response.data;

      if (body['error'] != null) {
        throw Exception('Erro no processo de autenticação: ${body['error']}');
      } else {
        await createCompany(body["pkUser"], company);
      }
    } catch (e) {
      // Aqui você pode logar o erro ou fazer algum tratamento adicional
      throw Exception('Falha no processo de cadastro: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateUser(UserUpdate userUpdate) async {
    final url = '${AppConstants.baseUrl}user/$_userId';

    try {
      final response = await dio.put(
        url,
        data: userUpdate.toJson(),
        options: Options(
          headers: {"Authorization": "Bearer $_token"},
          contentType: Headers.jsonContentType, //'application/json'
          responseType: ResponseType.json,
        ),
      );

      final body = response.data;

      if (body['error'] != null) {
        throw Exception('Erro no processo de actualização: ${body['error']}');
      } else {
        _email = body['email'];
        _phone = body['phone'];
        _userName = body['username'];
        _fullName = body['fullName'];
        _address = body['address'];
        _nif = body['nif'];
        _nationality = body['nationality'];
        _maritalStatus = body['maritalStatus'];

        Store.saveMap('userData', {
          'token': _token,
          'email': _email,
          'userId': _userId,
          'username': _userName,
          'fullName': _fullName,
          'address': _address,
          'nif': _nif,
          'nationality': _nationality,
          'maritalStatus': _maritalStatus,
          'expiryDate': _expiryDate
        });
      }
    } catch (e) {
      throw Exception('Erro no processo de actualização: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> changeUserPassword(ChangePassword changePassword) async {
    final url = '${AppConstants.baseUrl}user/$_userId/change-password';

    try {
      final response = await dio.put(
        url,
        data: changePassword.toJson(),
        options: Options(
          headers: {"Authorization": "Bearer $_token"},
          contentType: Headers.jsonContentType, //'application/json'
          responseType: ResponseType.json,
        ),
      );

      final body = response.data;

      if (body['error'] != null) {
        throw Exception('Erro no processo de actualização: ${body['error']}');
      }
    } catch (e) {
      throw Exception('Erro no processo de actualização: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> signupWithClient(UserSignup user, Client client) async {
    const url = '${AppConstants.baseUrl}auth/signup';

    try {
      final response = await dio.post(url, data: user.toJson());

      final body = response.data;

      if (body['error'] != null) {
        throw Exception('Erro no processo de autenticação: ${body['error']}');
      } else {
        await createClient(body["pkUser"], client);
      }
    } catch (e) {
      // Aqui você pode logar o erro ou fazer algum tratamento adicional
      throw Exception('Falha no processo de cadastro: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> createCompany(String pkUser, Company company) async {
    try {
      String urlCreateCompany = '${AppConstants.baseUrl}company/${pkUser}';

      final response = await dio.post(
        urlCreateCompany,
        data: company.toJson(),
      );

      final body = response.data;

      if (body['error'] != null) {
        throw Exception(
            'Ocorreu um erro no processo da criação da conta.: ${body}');
      } else {
        notifyListeners();
      }
    } catch (e) {
      throw Exception(
              'Ocorreu um erro no processo da criação da conta.: ${e.toString()}')
          .toString();
    }
  }

  Future<void> createClient(String pkUser, Client client) async {
    try {
      String urlCreateClient = '${AppConstants.baseUrl}client/${pkUser}';

      final response = await dio.post(
        urlCreateClient,
        data: client.toJson(),
      );

      final body = response.data;

      if (body['error'] != null) {
        throw Exception(
            'Ocorreu um erro no processo da criação da conta.: ${body}');
      } else {
        notifyListeners();
      }
    } catch (e) {
      throw Exception(
              'Ocorreu um erro no processo da criação da conta.: ${e.toString()}')
          .toString();
    }
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await Store.getMap('userData');

    if (userData.isEmpty) return;

    final expiryDate = userData['expiryDate'] as DateTime;
    if (expiryDate.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userId'];
    _userName = userData['username'];
    _fullName = userData['fullName'];
    _address = userData['address'];
    _nif = userData['nif'];
    _nationality = userData['nationality'];
    _maritalStatus = userData['maritalStatus'];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();
  }

  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void logout() {
    _token = null;
    _email = null;
    _userId = null;
    _userName = null;
    _roles = [];
    _clearLogoutTimer();
    Store.remove('userData').then((_) {
      notifyListeners();
    });
  }

  void _autoLogout() {
    _clearLogoutTimer();
    final timeToLogout = _expiryDate?.difference(DateTime.now()).inSeconds;

    _logoutTimer = Timer(
      Duration(seconds: timeToLogout ?? 0),
      logout,
    );
  }
}
