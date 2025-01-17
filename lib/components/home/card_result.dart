import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class CardResult extends StatelessWidget {
  final PropertyResult data;

  const CardResult({required this.data, super.key});

  Widget _extraInfo() {
    return Row(
      children: [
        Row(
          children: [
            const Icon(
              Icons.bed,
              size: 10,
              color: Color(0XFFFA3A2A9),
            ),
            const SizedBox(width: 4),
            AppText("${data.property.room} Quartos",
                fontSize: 10, color: const Color(0xFFFA3A2A9))
          ],
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            const Icon(
              Icons.water_drop,
              size: 10,
              color: Color(0XFFFA3A2A9),
            ),
            const SizedBox(width: 4),
            AppText("${data.property.bathroom} Banheiros",
                fontSize: 10, color: const Color(0xFFFA3A2A9))
          ],
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            const Icon(
              Icons.bathtub_rounded,
              size: 10,
              color: Color(0XFFFA3A2A9),
            ),
            const SizedBox(width: 4),
            AppText("${data.property.suits} Suites",
                fontSize: 10, color: Color(0xFFFA3A2A9))
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.IMMOBILE_DETAIL_SCREEN,
          arguments: data,
        );
      },
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  image: NetworkImage(data.images[0].url),
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    formatPrice(data.property.price),
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 4),
                  AppText("${data.property.province}, ${data.property.county}",
                      fontSize: 12, color: const Color(0xfff3D3F33)),
                  const SizedBox(height: 4),
                  _extraInfo()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
