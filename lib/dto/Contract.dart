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
  final String? signaturePropertyOwner;
  final String? signaturePropertyCustomer;

  Contract({
    required this.pkContract,
    required this.property,
    required this.startDate,
    required this.endDate,
    required this.user,
    required this.createdAt,
    required this.contractStatus,
    required this.signaturePropertyOwner,
    required this.signaturePropertyCustomer,
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
        signaturePropertyOwner: json['signaturePropertyOwner'],
        signaturePropertyCustomer: json['signaturePropertyCustomer']);
  }

  Contract copyWith({
    String? pkContract,
    Property? property,
    String? startDate,
    String? endDate,
    User? user,
    String? createdAt,
    String? contractStatus,
    String? signaturePropertyOwner,
    String? signaturePropertyCustomer,
  }) {
    return Contract(
      pkContract: pkContract ?? this.pkContract,
      property: property ?? this.property,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      contractStatus: contractStatus ?? this.contractStatus,
      signaturePropertyOwner:
          signaturePropertyOwner ?? this.signaturePropertyOwner,
      signaturePropertyCustomer:
          signaturePropertyCustomer ?? this.signaturePropertyCustomer,
    );
  }
}
