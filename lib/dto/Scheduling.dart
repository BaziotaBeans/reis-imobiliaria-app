import 'package:reis_imovel_app/dto/Property.dart';
import 'package:reis_imovel_app/dto/PropertyScheduleResult.dart';
import 'package:reis_imovel_app/dto/User.dart';

class Scheduling {
  final String pkScheduling;
  final PropertyScheduleResult propertySchedule;
  final Property property;
  final User user;
  final String? note;
  final String createdAt;
  final String scheduledDate;

  Scheduling({
    required this.pkScheduling,
    required this.propertySchedule,
    required this.property,
    required this.user,
    this.note,
    required this.createdAt,
    required this.scheduledDate,
  });

  factory Scheduling.fromJSON(Map<String, dynamic> json) {
    return Scheduling(
        pkScheduling: json['pkScheduling'],
        propertySchedule:
            PropertyScheduleResult.fromJson(json['propertySchedule']),
        property: Property.fromJson(json['property']),
        user: User.fromJson(json['user']),
        note: json['note'],
        createdAt: json['createdAt'],
        scheduledDate: json['scheduledDate']);
  }
}
