import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/models/Auh.dart';

class WelcomeArea extends StatelessWidget {
  const WelcomeArea({super.key});

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context, listen: false);

    final uName = auth.fullName?.split(' ')[0];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "Olá, $uName 👋🏽",
                fontSize: 14,
                color: const Color(0xFF88898F),
              ),
              const AppText(
                "Seja bem vindo",
                color: Color(0xFF3D3F33),
                fontWeight: FontWeight.w700,
                fontSize: 20,
                softWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
