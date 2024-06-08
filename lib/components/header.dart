import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/go-back-button.dart';

class Header extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;

  const Header({required this.title, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Stack(
        children: [
          const Positioned(
            top: 18,
            left: 20,
            child: GoBackButton(),
          ),
          Center(
            child: AppText(
              title,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xff3D3F33),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}
