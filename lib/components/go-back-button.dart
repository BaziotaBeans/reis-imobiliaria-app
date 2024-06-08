import 'package:flutter/material.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.800000011920929),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 16,
          weight: 100,
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
