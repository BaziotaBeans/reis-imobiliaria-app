import 'package:flutter/material.dart';

class SelectUserTypeHeader extends StatelessWidget {
  const SelectUserTypeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bem vindo!",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xff3D3F33),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          'Selecione o tipo de usuário que pretende criar conta.',
          style: TextStyle(
            color: Color(0xFF74778B),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
