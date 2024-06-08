import 'package:reis_imovel_app/dto/Property.dart';
import 'package:reis_imovel_app/dto/User.dart';

class Contract {
  final String pkContract;
  final Property property;
  final String startDate;
  final String? endDate;
  final User user;
  final String createdAt;
  final String contractStatus;

  Contract({
    required this.pkContract,
    required this.property,
    required this.startDate,
    required this.endDate,
    required this.user,
    required this.createdAt,
    required this.contractStatus,
  });

  factory Contract.fromJSON(Map<String, dynamic> json) {
    return Contract(
      pkContract: json['pkContract'],
      property: Property.fromJson(json['property']),
      startDate: json['startDate'],
      endDate: json['endDate'],
      user: User.fromJson(json['user']),
      createdAt: json['createdAt'],
      contractStatus: json['contractStatus'],
    );
  }
}