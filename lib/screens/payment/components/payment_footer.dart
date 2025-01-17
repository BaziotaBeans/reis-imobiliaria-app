import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/screens/payment/components/payment_security_info.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class PaymentFooter extends StatelessWidget {
  const PaymentFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/Emis.svg",
            width: 102,
          ),
          const SizedBox(height: defaultPadding),
          const CustomText(
            'Informação tratada pela EMIS e não será fornecida ao comerciante.',
            fontSize: 12,
            color: secondaryText,
            textAlign: TextAlign.center,
            maxLines: 2,
            softWrap: true,
          ),
          const SizedBox(height: 10),
          const PaymentSecurityInfo(),
        ],
      ),
    );
  }
}
