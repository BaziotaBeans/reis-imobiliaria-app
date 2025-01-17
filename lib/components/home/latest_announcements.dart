import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/home/card_latest_announcement.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class LatestAnnouncements extends StatelessWidget {
  final List<PropertyResult> data;

  const LatestAnnouncements({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              'Últimos anúncios',
              textAlign: TextAlign.center,
              color: secondaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              // height: 0.06,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.LATEST_ANNOUNCEMENT_SCREEN,
                  arguments: data,
                );
              },
              child: const CustomText(
                'Ver Todos',
                textAlign: TextAlign.center,
                color: secondaryText,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: width - (AppConstants.defaultPadding * 2),
          height: 229, //314.0,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return CardLatestAnnouncement(data: data[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 16);
            },
          ),
        ),
      ],
    );
  }
}
