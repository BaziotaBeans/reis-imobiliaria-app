import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/Property.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class PropertyCardResult extends StatelessWidget {
  final Property data;
  final String imgUrl;
  final VoidCallback onTap;

  const PropertyCardResult({
    required this.data,
    required this.imgUrl,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 120,
        child: Card(
          color: whiteColor,
          surfaceTintColor: whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imgUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      data.title,
                      color: secondaryColor,
                      fontWeight: FontWeight.w500,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          formatPrice(data.price),
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/Room.svg",
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(
                            secondaryText,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 6),
                        CustomText(
                          data.room.toString(),
                          color: secondaryText,
                          fontSize: 12,
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          "assets/icons/Bathroom.svg",
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(
                            secondaryText,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 6),
                        CustomText(
                          data.bathroom.toString(),
                          color: secondaryText,
                          fontSize: 12,
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          "assets/icons/Suit.svg",
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(
                            secondaryText,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 6),
                        CustomText(
                          data.suits.toString(),
                          color: secondaryText,
                          fontSize: 12,
                        ),
                        const SizedBox(width: 6),
                        // const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: CustomText(
                              data.fkPropertyTypeEntity.designation,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: whiteColor,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
