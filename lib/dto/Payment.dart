import 'package:reis_imovel_app/dto/Property.dart';
import 'package:reis_imovel_app/dto/User.dart';

class Payment {
  final String pkPayment;
  final Property property;
  final User user;
  final String createdAt;
  final double totalValue;
  final String reference;
  final String? paymentMethod;

  Payment({
    required this.pkPayment,
    required this.property,
    required this.user,
    required this.createdAt,
    required this.totalValue,
    required this.reference,
    required this.paymentMethod,
  });

  factory Payment.fromJSON(Map<String, dynamic> json) {
    return Payment(
      pkPayment: json['pkPayment'],
      property: Property.fromJson(json['property']),
      user: User.fromJson(json['user']),
      createdAt: json['createdAt'],
      totalValue: json['totalValue'],
      reference: json['reference'],
      paymentMethod: json['paymentMethod'],
    );
  }
}
