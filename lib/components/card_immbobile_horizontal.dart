// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class CardImmobileHorizontal extends StatelessWidget {
  final PropertyResult data;

  const CardImmobileHorizontal({required this.data, super.key});

  Widget _boxDescription(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            data.property.title,
            color: secondaryColor,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: primaryColor,
                size: 18,
              ),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                child: CustomText(
                  '${data.property.province} ${data.property.county}',
                  color: secondaryText,
                  fontSize: 14,
                  height: 0,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  CustomText(
                    'Ver anúncio',
                    color: primaryColor,
                    fontSize: 15,
                  ),
                  SizedBox(width: 2),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: primaryColor,
                    size: 14,
                  )
                ],
              ),
              CustomText(
                AppUtils.formatDateDayAndMounth(
                  data.property.createdAt.toString(),
                ),
                color: secondaryText,
                fontSize: 12,
              )
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
        //AppRoutes.AnnouncementPreviewDetail
        Navigator.of(context).pushNamed(
          AppRoutes.AnnouncementPreviewDetail,
          arguments: data,
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 85,
              height: 69,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(data.images[0].url),
                  fit: BoxFit.fill,
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            const SizedBox(width: 14),
            _boxDescription(context)
          ],
        ),
      ),
    );
  }
}
