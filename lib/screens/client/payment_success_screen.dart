import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Center(
                child: AppText(
                  'Obrigado por arrendar',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/confetti.png',
                  width: 206,
                  height: 206,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  const Center(
                    child: AppText(
                      'Pedido #123RGR231567Y confirmado',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 0.05,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                    title: 'Ver contrato',
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.CONTRACT_SCREEN);
                    },
                    variant: ButtonVariant.primary,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                    title: 'Voltar na home',
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.Home);
                    },
                    variant: ButtonVariant.tertiary,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
