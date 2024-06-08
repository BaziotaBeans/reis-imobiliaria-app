import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';

class AppLoadForm extends StatelessWidget {
  const AppLoadForm({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              LoadingAnimationWidget.inkDrop(
                color: AppColors.primaryColor,
                size: 150,
              ),
              const SizedBox(height: 40),
              AppText('Carregando..', color: Colors.grey[600])
            ],
          ),
        ),
      ),
    );
  }
}
