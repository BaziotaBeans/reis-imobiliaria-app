import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class PaymentDetail extends StatelessWidget {
  final double totalToPaid;
  final String reference;
  final String typeItem;

  const PaymentDetail({
    super.key,
    required this.totalToPaid,
    required this.reference,
    required this.typeItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              'Montante',
              color: whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            CustomText(
              formatPrice(totalToPaid),
              color: whiteColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              'Referência',
              color: whiteColor,
              fontSize: 14,
            ),
            CustomText(
              reference,
              color: whiteColor,
              fontSize: 14,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              'Tipo Item',
              color: whiteColor,
              fontSize: 14,
            ),
            CustomText(
              typeItem,
              color: whiteColor,
              fontSize: 14,
            ),
          ],
        ),
      ],
    );
  }
}
