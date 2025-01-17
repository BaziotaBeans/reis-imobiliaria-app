import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/enums.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class StatusBox extends StatelessWidget {
  const StatusBox({
    super.key,
    required this.data,
  });

  final Contract data;

  @override
  Widget build(BuildContext context) {
    Color bgColor = AppUtils.isContractDateValid(data.endDate) ||
            data.property.propertyStatus == PropertyStatus.RENTED.name
        ? successColor.withOpacity(0.2)
        : errorColor.withOpacity(0.2);

    Color textColor = AppUtils.isContractDateValid(data.endDate) ||
            data.property.propertyStatus == PropertyStatus.RENTED.name
        ? successColor
        : errorColor;

    String title = AppUtils.isContractDateValid(data.endDate) ||
            data.property.propertyStatus == PropertyStatus.RENTED.name
        ? 'Activo'
        : 'Inactivo';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(defaultBorderRadious)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_rounded,
            color: textColor,
            size: 16,
          ),
          const SizedBox(width: 4),
          CustomText(
            title,
            color: textColor,
          )
        ],
      ),
    );
  }
}
