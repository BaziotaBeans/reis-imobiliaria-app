import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class SubtitlePage extends StatelessWidget {
  final String description;

  const SubtitlePage({required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      description,
      color: secondaryText,
      fontSize: 14,
      softWrap: true,
      maxLines: 3,
    );
  }
}
