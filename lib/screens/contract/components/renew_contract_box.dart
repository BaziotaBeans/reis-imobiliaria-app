import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class RenewContractBox extends StatelessWidget {
  const RenewContractBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: alertBoxColor,
        borderRadius: BorderRadius.circular(defaultBorderRadious),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'Aguardando a renovação do contracto',
                color: whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SvgPicture.asset(
                "assets/icons/Alert.svg",
                height: 16,
                width: 16,
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          const Expanded(
            child: CustomText(
              'Ao renovar o contracto será reencaminhado para a tela de pagamento, e deverá efectuar o pagamento para posteriormente fazer assinatura e assim ter novamente acesso ao imóvel.',
              color: whiteColor,
              fontSize: 14,
              softWrap: true,
              maxLines: 6,
            ),
          ),
          const SizedBox(height: defaultPadding),
          CustomButton(
            text: 'Renovar Contracto',
            variant: ButtonVariant.tertiary,
            forcedTextColor: alertBoxColor,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
