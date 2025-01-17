import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_back_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class Header extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;

  const Header({required this.title, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Stack(
        children: [
          const Positioned(
            top: 12,
            left: 20,
            child: CustomBackButton(),
          ),
          Center(
            child: CustomText(
              title,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: secondaryColor,
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}
