import 'package:flutter/material.dart';

class TitleForm extends StatelessWidget {
  final String title;

  const TitleForm({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
