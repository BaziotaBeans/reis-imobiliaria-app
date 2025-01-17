import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Center(child: Icon(Icons.arrow_back_ios)),
      iconSize: 24,
      color: Theme.of(context).primaryColor,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
