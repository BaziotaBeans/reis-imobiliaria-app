import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/card_immobile_highlight.dart';
import 'package:reis_imovel_app/data/dummy_data.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/models/Immobile.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';

class ForSale extends StatelessWidget {
  final List<PropertyResult> data;

  const ForSale({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    List<Immobile> carouselItems = dummyImmobiles;
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
              const AppText(
                'Todos Imóveis',
                textAlign: TextAlign.center,
                color: Color(0xFF3D3F33),
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.ALL_IMMOBILE_SCREEN,
                    arguments: data,
                  );
                },
                child: const AppText(
                  'Ver Todos',
                  textAlign: TextAlign.center,
                  color: Color(0xFFF88898F),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
