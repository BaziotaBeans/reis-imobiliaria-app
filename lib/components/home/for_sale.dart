import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/card_immobile_highlight.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class ForSale extends StatelessWidget {
  final List<PropertyResult> data;

  const ForSale({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                'Todos Imóveis',
                textAlign: TextAlign.center,
                color: secondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.ALL_IMMOBILE_SCREEN,
                    arguments: data,
                  );
                },
                child: const CustomText(
                  'Ver Todos',
                  textAlign: TextAlign.center,
                  color: secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: screenHeight,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              // childAspectRatio: 2 / 3,
              childAspectRatio: 11 / 12,
            ),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return CardImmobileHighlight(data: data[index]);
            },
          ),
        ),
      ],
    );
  }
}
