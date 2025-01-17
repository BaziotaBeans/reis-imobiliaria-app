import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class TitlePage extends StatelessWidget {
  final String title;

  const TitlePage({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title,
      color: secondaryColor,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }
}
