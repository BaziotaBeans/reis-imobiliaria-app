import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class CardImmobileHighlight extends StatelessWidget {
  final PropertyResult data;

  const CardImmobileHighlight({required this.data, super.key});

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
        // width: widthSize,
        padding: const EdgeInsets.all(12),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // width: 123,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(data.images[0].url),
                  fit: BoxFit.cover,
                ),
              ),
              height: 110,
            ),
            const SizedBox(
              height: 10,
            ),
            AppText(
              data.property.title,
              color: const Color(0xFF3D3F33),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            AppText(
              formatPrice(data.property.price),
              color: Colors.grey[500],
              fontSize: 12,
              fontWeight: FontWeight.w500,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: primaryColor,
                ),
                Expanded(
                  child: Text(
                    "${data.property.province}, ${data.property.county}",
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                    ),
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
