import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/components/card_detail_image_slider.dart';
import 'package:reis_imovel_app/components/go-back-button.dart';
import 'package:reis_imovel_app/components/modality_payment_info.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/components/new/expandable_text.dart';
import 'package:reis_imovel_app/components/schedule_picker.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/enums.dart';
import 'package:reis_imovel_app/models/PropertyScheduleList.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';
import 'package:reis_imovel_app/utils/format_number_with_sufix.dart';

class ImmobileDetailScreen extends StatefulWidget {
  const ImmobileDetailScreen({super.key});

  @override
  State<ImmobileDetailScreen> createState() => _ImmobileDetailScreenState();
}

class _ImmobileDetailScreenState extends State<ImmobileDetailScreen> {
  Widget _cardPrimary(BuildContext context, PropertyResult data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 314,
      child: Stack(
        children: [
          Positioned(
            child: CardDetailImageSlider(images: data.images),
          ),
          const Positioned(
            top: 10,
            left: 10,
            child: GoBackButton(),
          ),
          // const Positioned(
          //   bottom: 30,
          //   left: 20,
          //   child: FavoriteButton(),
          // )
        ],
      ),
    );
  }

  IconData getIconToBoxDetailItemExtra(BoxDetailItemExtraEnum type) {
    switch (type) {
      case BoxDetailItemExtraEnum.bathroom:
        return Icons.water_drop;
      case BoxDetailItemExtraEnum.room:
        return Icons.bed;
      case BoxDetailItemExtraEnum.suites:
        return Icons.bathtub_rounded;
      case BoxDetailItemExtraEnum.vacancy:
        return Icons.car_crash;
    }
  }

  Widget _boxDetailItemExtra(
      String title, int quantity, BoxDetailItemExtraEnum type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          color: secondaryText,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.30,
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              getIconToBoxDetailItemExtra(type),
              color: primaryColor,
              size: 18,
            ),
            const SizedBox(
              width: 4,
            ),
            CustomText(
              quantity.toString(),
              color: secondaryText,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.42,
            ),
          ],
        )
      ],
    );
  }

  Widget _paymentModality(String title, String value) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: ShapeDecoration(
        color: const Color.fromARGB(255, 246, 246, 246),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title,
            color: secondaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomText(
            value,
            color: secondaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.36,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: ModalityPaymentInfo(),
                  );
                },
              );
            },
            child: const Row(
              children: [
                FaIcon(FontAwesomeIcons.circleInfo,
                    size: 20, color: primaryColor),
                SizedBox(width: 8),
                CustomText('Clique aqui para mais informções.',
                    color: secondaryText)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _boxDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          color: secondaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.30,
        ),
        const SizedBox(
          height: 8,
        ),
        CustomText(
          value,
          color: secondaryText,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.36,
        ),
      ],
    );
  }

  Widget _boxDetail(BuildContext context, PropertyResult data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(14),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 20,
            runSpacing: 20,
            children: [
              _boxDetailItem('Finalidade',
                  AppUtils.getPropertyTypeLabel(data.property.fkPropertyType)),
              _boxDetailItem(
                  'Valor', AppUtils.formatPrice(data.property.price)),
              // _boxDetailItem('Taxa do condominio', 'N/I'),
            ],
          ),
          if (!(data.property.fkPropertyType ==
              AppConstants.propertyTypeGround))
            const SizedBox(height: 10),
          if (!(data.property.fkPropertyType ==
              AppConstants.propertyTypeGround))
            Row(
              children: [
                _boxDetailItemExtra('Suites', data.property.suits,
                    BoxDetailItemExtraEnum.suites),
                const SizedBox(
                  width: 20,
                ),
                _boxDetailItemExtra(
                    'Quartos', data.property.room, BoxDetailItemExtraEnum.room),
                const SizedBox(
                  width: 20,
                ),
                _boxDetailItemExtra('Banheiros', data.property.bathroom,
                    BoxDetailItemExtraEnum.bathroom),
                const SizedBox(
                  width: 20,
                ),
                _boxDetailItemExtra('Vagas', data.property.vacancy,
                    BoxDetailItemExtraEnum.vacancy),
              ],
            ),
          if (data.property.fkPropertyType == AppConstants.propertyTypeRent)
            const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _descriptionBlock(String? description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpandableText(
          title: "Descrição",
          description: description ?? 'Sem descrição',
          titleStyle: const TextStyle(
            color: secondaryColor,
            fontWeight: FontWeight.w500,
          ),
          descriptionStyle: const TextStyle(
            color: secondaryText,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _contactBox(BuildContext context, PropertyResult data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
      decoration: ShapeDecoration(
        color: const Color.fromARGB(255, 246, 246, 246),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                data.property.companyEntity.user.fullName,
                color: const Color(0xFF3D3F33),
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.42,
              ),
              const SizedBox(
                height: 4,
              ),
              const CustomText(
                'Imobiliário',
                color: Color(0xFF3D3F33),
                fontSize: 12,
              ),
            ],
          ),
          const Row(
            children: [
              Icon(
                Icons.phone,
                color: primaryColor,
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.message,
                color: primaryColor,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _displayDetail(BuildContext context, PropertyResult data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 180,
                child: CustomText(
                  data.property.title,
                  color: secondaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 96,
                child: CustomText(
                  formatNumberWithSufix(data.property.price),
                  textAlign: TextAlign.right,
                  color: primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: primaryColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  CustomText(
                    "${data.property.province}, ${data.property.county}",
                    color: secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              if (data.property.fkPropertyType == AppConstants.propertyTypeRent)
                const CustomText(
                  'por mês',
                  textAlign: TextAlign.right,
                  color: Color(0xFFA3A2A9),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.36,
                ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Color(0xfffA3A2A9)),
          _boxDetail(context, data),
          if (data.property.description.isNotEmpty)
            _descriptionBlock(data.property.description),
          // if (data.property.description.isNotEmpty)
          // const SizedBox(height: defaultPadding),
          const SizedBox(height: 20),
          if (data.property.fkPropertyType == AppConstants.propertyTypeRent)
            _paymentModality(
                'Modalidade de pagamento', data.property.paymentModality)
        ],
      ),
    );
  }

  void _rent(BuildContext context, PropertyResult data) {
    Navigator.of(context).pushNamed(
      AppRoutes.PAYMENT_METHOD_SCREEN,
      arguments: data,
    );
  }

  void _showSchedulePicker(BuildContext context, String pkProperty) async {
    await Provider.of<PropertyScheduleList>(context, listen: false)
        .findAvailableSchedulesByPropertyId(pkProperty);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Material(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: SchedulePicker(
                pkProperty: pkProperty,
              ),
            )
          ],
        );
      },
    );
  }

  Widget _footer(BuildContext context, PropertyResult data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(22),
      color: const Color.fromARGB(255, 246, 246, 246),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            data.property.fkPropertyType == AppConstants.propertyTypeRent
                ? 'Preço do aluguel'
                : 'Preço da compra',
            textAlign: TextAlign.center,
            color: const Color(0xFFA3A2A9),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 12,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: formatPrice(data.property.price),
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (data.property.fkPropertyType ==
                    AppConstants.propertyTypeRent)
                  const TextSpan(
                    text: ' / mês',
                    style: TextStyle(
                      color: Color(0xFFA3A2A9),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Button(
            title: data.property.fkPropertyType == AppConstants.propertyTypeRent
                ? "Arrendar Agora"
                : "Comprar Agora",
            onPressed: () {
              _rent(context, data);
            },
            variant: ButtonVariant.primary,
          ),
          const SizedBox(height: 20),
          const Divider(color: Color.fromARGB(255, 160, 160, 160), height: 10),
          const SizedBox(height: 20),
          const CustomText(
            'Solicitar visita domiciliar',
            textAlign: TextAlign.center,
            color: secondaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 20),
          Button(
            title: 'Agendar Agora',
            onPressed: () {
              _showSchedulePicker(context, data.property.pkProperty);
            },
            variant: ButtonVariant.secondary,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PropertyResult data =
        ModalRoute.of(context)?.settings.arguments as PropertyResult;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _cardPrimary(context, data),
              const SizedBox(height: defaultPadding),
              _displayDetail(context, data),
              Padding(
                padding: const EdgeInsets.all(16),
                child: _contactBox(context, data),
              ),
              const SizedBox(
                height: 20,
              ),
              _footer(context, data)
            ],
          ),
        ),
      ),
    );
  }
}
