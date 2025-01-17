import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/utils/constants.dart';

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
                color: secondaryText,
              ),
              const AppText(
                "Seja bem vindo",
                color: secondaryColor,
                fontWeight: FontWeight.w600,
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
