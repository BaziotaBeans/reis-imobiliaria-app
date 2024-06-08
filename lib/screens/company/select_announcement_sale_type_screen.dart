import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';

class SelectAnnouncementSaleTypeScreen extends StatefulWidget {
  const SelectAnnouncementSaleTypeScreen({super.key});

  @override
  State<SelectAnnouncementSaleTypeScreen> createState() =>
      _SelectAnnouncementSaleTypeScreenState();
}

class _SelectAnnouncementSaleTypeScreenState
    extends State<SelectAnnouncementSaleTypeScreen> {
  String anncounementType = "sale"; //ground

  Widget _announcementTypeBox(String type) {
    double screenWidth = MediaQuery.of(context).size.width;

    double containerWidth =
        ((screenWidth / 2) - AppConstants.screenHorizontalPadding) -
            (AppConstants.selectUserTypeGapBetweenBox / 2);

    return InkWell(
      onTap: () {
        setState(
          () {
            anncounementType = type;
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: containerWidth,
            height: 115,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2,
                  color: type == anncounementType
                      ? AppColors.primaryColor
                      : const Color(0xFFE2E2E2),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                if (anncounementType == type)
                  Positioned(
                    top: -10,
                    left: (containerWidth / 2) - 14,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: ShapeDecoration(
                        color: AppColors.primaryColor,
                        shape: const OvalBorder(),
                      ),
                      child: const Center(
                        child: Icon(Icons.check, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                Positioned(
                  top: 20,
                  width: containerWidth,
                  child: Icon(
                    Icons.house_siding_outlined,
                    size: 64,
                    color: anncounementType == type
                        ? AppColors.primaryColor
                        : const Color(0xFFE2E2E2),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: AppText(
              type == 'sale' ? 'Apartamento' : 'Terreno',
              textAlign: TextAlign.center,
              color: anncounementType == type
                  ? AppColors.primaryColor
                  : const Color(0xFFE2E2E2),
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }

  Widget _announcementTypeOption() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40),
      padding: const EdgeInsets.all(30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _announcementTypeBox('sale'),
          const SizedBox(width: AppConstants.selectUserTypeGapBetweenBox),
          _announcementTypeBox('ground')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Header(title: 'Selelecione o tipo de venda', onPressed: () {}),
                _announcementTypeOption()
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Button (
                title: 'Continuar',
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    anncounementType == 'sale'
                        ? AppRoutes.FormCreateImmboleForRent
                        : AppRoutes.FormCreateImmboleForGround,
                    arguments: anncounementType == 'sale'
                        ? AppConstants.propertyTypeSale
                        : AppConstants.propertyTypeGround,
                  );
                },
                variant: ButtonVariant.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
