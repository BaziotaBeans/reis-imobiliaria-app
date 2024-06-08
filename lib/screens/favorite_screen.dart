import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppText("Sem itens favoritos!"),
      ),
    );
  }
}