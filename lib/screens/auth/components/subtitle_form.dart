import 'package:flutter/material.dart';

class SubtitleForm extends StatelessWidget {
  final String description;

  const SubtitleForm({required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
