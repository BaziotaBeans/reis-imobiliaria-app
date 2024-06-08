import 'package:reis_imovel_app/models/Immobile.dart';

class Contract {
  final Immobile immobile;
  final DateTime startDate;
  final DateTime endDate;

  Contract({
    required this.immobile,
    required this.startDate,
    required this.endDate,
  });
}


