import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
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

  List<dynamic> _roles = [];
  final dio = Dio();
  // DateTime? _expiryDate;

  bool get isAuth {
    return _token != null;
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
      final response = await dio.post(
        url,
        data: {
          'username': userName,
          'password': password,
        },
      );

      final body = response.data;

      if (body['error'] != null) {
        throw Exception(
            'Ocorreu um erro no processo de autenticação.: ${body}');
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

        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Ocorreu um erro no processo de autenticação.')
          .toString();
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

  Future<void> signupWithCompany(
    UserSignup user,
    Company company,
  ) async {
    const url = '${AppConstants.baseUrl}auth/signup';

    final response = await dio.post(url, data: user.toJson());

    final body = response.data;

    if (body['error'] != null) {
      throw Exception('Ocorreu um erro no processo de autenticação.: ${body}');
    } else {
      await createCompany(body["pkUser"], company);

      notifyListeners();
    }
  }

  Future<void> signupWithClient(
    UserSignup user,
    Client client,
  ) async {
    const url = '${AppConstants.baseUrl}auth/signup';

    final response = await dio.post(url, data: user.toJson());

    final body = response.data;

    if (body['error'] != null) {
      throw Exception('Ocorreu um erro no processo de autenticação.: ${body}');
    } else {
      await createClient(body["pkUser"], client);

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

  void logout() {
    _token = null;
    _email = null;
    _userId = null;
    _userName = null;
    _roles = [];
    notifyListeners();
  }
}
