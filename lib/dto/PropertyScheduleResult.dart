import 'package:reis_imovel_app/dto/Property.dart';

class PropertyScheduleResult {
  final String pkPropertySchedule;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final Property property;

  PropertyScheduleResult({
    required this.pkPropertySchedule,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.property,
  });

  factory PropertyScheduleResult.fromJson(Map<String, dynamic> json) {
    return PropertyScheduleResult(
      pkPropertySchedule: json['pkPropertySchedule'],
      dayOfWeek: json['dayOfWeek'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      property: Property.fromJson(json['property']),
    );
  }
}
