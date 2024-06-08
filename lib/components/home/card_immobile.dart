import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/home/favorite_button.dart';
import 'package:reis_imovel_app/components/tag_immobile.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class CardImmobile extends StatelessWidget {
  final PropertyResult data;

  const CardImmobile({required this.data, super.key});

  Widget _boxDetail() {
    return Container(
      width: 298,
      height: 100,
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: ShapeDecoration(
        color: const Color(0xFFF9F9FA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: AppText(
                  data.property.title,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                  color: const Color(0xFF2C3A61),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 40),
              AppText(
                formatPrice(data.property.price),
                color: const Color(0xFF1886F9),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF1886F9),
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 100,
                    child: AppText(
                      "${data.property.province}, ${data.property.county}",
                      textAlign: TextAlign.center,
                      color: const Color(0xFF86868A),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (data.property.fkPropertyType == AppConstants.propertyTypeRent)
                const AppText(
                  'por mês',
                  color: Color(0xFF86868A),
                  fontSize: 10,
                ),
            ],
          )
        ],
      ),
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: NetworkImage(data.images[0].url),
            fit: BoxFit.cover,
          ),
        ),
        width: 335.0,
        height: 250.0,
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: TagImmobile(
                type: AppUtils.getPropertyTypeTag(data.property.fkPropertyType),
              ),
            ),
            const Positioned(
              top: 14,
              right: 14,
              child: FavoriteButton(),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: _boxDetail(),
            )
          ],
        ),
      ),
    );
  }
}
