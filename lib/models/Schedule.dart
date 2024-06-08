import 'package:flutter/material.dart';

class Schedule {
  final String dayOfWeek;
  final String startTime;
  final String endTime;

  Schedule({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() => {
    'dayOfWeek': dayOfWeek,
    'startTime': startTime,
    'endTime': endTime,
  };
}