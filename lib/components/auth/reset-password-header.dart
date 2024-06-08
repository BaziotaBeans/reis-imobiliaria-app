import 'package:flutter/material.dart';

class ResetPasswordHeader extends StatelessWidget {
  const ResetPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Redefinir senha",
          style: TextStyle(
            fontFamily: 'Avenir',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xff2c3a61),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          'Por favor preencha os campos abaixo para redefinir a sua senha.',
          style: TextStyle(
            color: Color(0xFF74778B),
            fontSize: 16,
            fontFamily: 'Avenir',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
