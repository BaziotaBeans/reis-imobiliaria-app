import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class PaymentPropertyDetail extends StatelessWidget {
  final PropertyResult data;

  const PaymentPropertyDetail({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.all(Radius.circular(defaultBorderRadious)),
            child: Image.network(
              data.images[0].url,
              fit: BoxFit.cover,
              height: 72,
              width: 106,
            ),
          ),
          const SizedBox(width: defaultPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                data.property.title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/Location.svg",
                    colorFilter: const ColorFilter.mode(
                      secondaryText,
                      BlendMode.srcIn,
                    ),
                    width: 16,
                  ),
                  const SizedBox(width: 6),
                  CustomText(
                    data.property.address,
                    color: secondaryText,
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  text: formatPrice(data.property.price),
                  style: const TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  children: [
                    if (data.property.fkPropertyTypeEntity.designation ==
                        'Arrendamento')
                      TextSpan(
                        text: '/mês',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        // recognizer: TapGestureRecognizer()..onTap = () => {print('yes')},
                      )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
