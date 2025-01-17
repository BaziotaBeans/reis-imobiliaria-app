import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class PaymentMulticaixaExpressInfo extends StatelessWidget {
  const PaymentMulticaixaExpressInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Center(
          child: Image.asset(
            'assets/images/express-box.png',
            width: 64.0,
            height: 64.0,
          ),
        ),
        const SizedBox(height: 24),
        const CustomText(
          'Pague com Multicaixa Express',
          color: whiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: defaultPadding),
        Text.rich(
          TextSpan(
            text:
                'Digite o seu número de telefone associado a tua conta express para ser reflectido o desconto, em caso de dúvida  ',
            style: const TextStyle(
              color: whiteColor,
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: 'clique aqui.',
                style: const TextStyle(
                  color: whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: whiteColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => {print('yes')},
              )
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
