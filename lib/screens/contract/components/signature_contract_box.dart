import 'package:flutter/material.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class SignatureContractBox extends StatelessWidget {
  final Contract data;

  const SignatureContractBox({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding),
        const CustomText(
          'Assinatura do Locatório:',
          fontSize: 14,
          color: secondaryText,
        ),
        CustomText(
          data.user.fullName,
          fontSize: 14,
          color: secondaryText,
        ),
        const SizedBox(height: defaultPadding),
        Center(
          child: Text(
            data.signaturePropertyCustomer ?? '---',
            style: const TextStyle(
              fontSize: 32,
              fontFamily: 'Sign Painter',
              fontWeight: FontWeight.w500,
              color: secondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: defaultPadding),
        const CustomText(
          'Assinatura do Locador:',
          fontSize: 14,
          color: secondaryText,
        ),
        CustomText(
          data.property.companyEntity.user.fullName,
          fontSize: 14,
          color: secondaryText,
        ),
        const SizedBox(height: defaultPadding),
        Center(
          child: Text(
            data.signaturePropertyOwner ?? '---',
            style: const TextStyle(
              fontSize: 32,
              fontFamily: 'Sign Painter',
              fontWeight: FontWeight.w500,
              color: secondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
