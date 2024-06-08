import 'package:reis_imovel_app/dto/User.dart';

class CompanyEntity {
  final String pkCompany;
  final String nif;
  final String bankName;
  final String bankAccountNumber;
  final bool status;
  final String iban;
  final User user;
  final String createdAt;

  CompanyEntity({
    required this.pkCompany,
    required this.nif,
    required this.bankName,
    required this.bankAccountNumber,
    required this.status,
    required this.iban,
    required this.user,
    required this.createdAt,
  });

  factory CompanyEntity.fromJson(Map<String, dynamic> json) {
    return CompanyEntity(
      pkCompany: json['pkCompany'],
      nif: json['nif'],
      bankName: json['bankName'],
      bankAccountNumber: json['bankAccountNumber'],
      status: json['status'],
      iban: json['iban'],
      user: User.fromJson(json['user']),
      createdAt: json['createdAt'],
    );
  }
}
