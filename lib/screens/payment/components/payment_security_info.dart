import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class PaymentSecurityInfo extends StatelessWidget {
  const PaymentSecurityInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/Security.svg",
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 10),
          const CustomText(
            'Suas informações estão seguras',
            color: secondaryText,
            fontSize: 12,
          )
        ],
      ),
    );
  }
}
