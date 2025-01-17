import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/screens/contract/components/status_box.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class ContractCard extends StatelessWidget {
  const ContractCard({
    super.key,
    required this.context,
    required this.data,
    required this.index,
  });

  final BuildContext context;
  final Contract data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.CONTRACT_SCREEN,
          arguments: data,
        );
      },
      child: Card(
        color: bgContractCard,
        elevation: 0,
        borderOnForeground: true,
        surfaceTintColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          height: 90,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 4,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Contract.svg",
                      height: 52,
                      width: 52,
                    ),
                  ],
                ),
              ),
              Positioned(
                right: -4,
                top: -4,
                child: StatusBox(data: data),
              ),
              Positioned(
                left: 62,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      'Contracto #${index}',
                      color: secondaryText,
                      fontSize: 12,
                    ),
                    CustomText(
                      '${data.property.title}',
                      color: secondaryColor,
                      fontSize: 16,
                    ),
                    CustomText(
                      'Data: ${AppUtils.formatDateDayMounthAndYear(data.startDate)}',
                      color: secondaryText,
                      fontSize: 12,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
