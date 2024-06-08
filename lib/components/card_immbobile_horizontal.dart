import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';

class CardImmobileHorizontal extends StatelessWidget {
  final PropertyResult data;

  const CardImmobileHorizontal({required this.data, super.key});

  Widget _boxDescription(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            data.property.title,
            color: const Color(0xFF252D4B),
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.primaryColor,
                size: 18,
              ),
              const SizedBox(
                width: 6,
              ),
              AppText(
                '${data.property.province} ${data.property.county}',
                color: const Color(0xFF2C3A61),
                fontSize: 14,
                height: 0,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const AppText(
                    'Ver anúncio',
                    color: Color(0xFF1886F9),
                    fontSize: 15,
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.primaryColor,
                    size: 14,
                  )
                ],
              ),
              AppText(
                AppUtils.formatDateDayAndMounth(
                    data.property.createdAt.toString()),
                color: const Color(0xFF6A7380),
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
        Navigator.of(context)
            .pushNamed(AppRoutes.AnnouncementPreviewDetail, arguments: data);
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
        child: Container(
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
                      borderRadius: BorderRadius.circular(7)),
                ),
              ),
              const SizedBox(width: 14),
              _boxDescription(context)
            ],
          ),
        ),
      ),
    );
  }
}
