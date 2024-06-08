import 'package:reis_imovel_app/dto/Property.dart';
import 'package:reis_imovel_app/dto/User.dart';

class Order {
  final String pkOrder;
  final User user;
  final String reference;
  final String expirationDate;
  final String createdAt;
  final String entidade;
  final Property property;
  final String orderState;
  final double totalValue;

  Order({
    required this.pkOrder,
    required this.user,
    required this.reference,
    required this.expirationDate,
    required this.createdAt,
    required this.entidade,
    required this.property,
    required this.orderState,
    required this.totalValue
  });

  factory Order.fromJSON(Map<String, dynamic> json) {
    return Order(
      pkOrder: json['pkOrder'],
      user: User.fromJson(json['user']),
      reference: json['reference'],
      expirationDate: json['expirationDate'],
      createdAt: json['createdAt'],
      entidade: json['entidade'],
      property: Property.fromJson(json['property']),
      orderState: json['orderState'],
      totalValue: json['totalValue'],
    );
  }
}
