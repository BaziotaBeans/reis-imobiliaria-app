import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/components/card_detail_image_slider.dart';
import 'package:reis_imovel_app/components/go-back-button.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/enums.dart';
import 'package:reis_imovel_app/models/PropertyList.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';

class AnnouncementPreviewDetailScreen extends StatefulWidget {
  const AnnouncementPreviewDetailScreen({super.key});

  @override
  State<AnnouncementPreviewDetailScreen> createState() =>
      _AnnouncementPreviewDetailScreenState();
}

class _AnnouncementPreviewDetailScreenState
    extends State<AnnouncementPreviewDetailScreen> {
  bool _isLoading = false;

  Widget _tagStatus(String propertyStatus) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: ShapeDecoration(
        color: const Color(0xFF393E67),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: AppText(
        AppUtils.getPropertyStatusLabel(propertyStatus),
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
    );
  }

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
          Positioned(
            top: 10,
            right: 10,
            child: _tagStatus(data.property.propertyStatus),
          )
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
        AppText(
          title,
          color: Colors.grey[600],
          fontSize: 14,
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
              color: const Color(0xFF393E67),
              size: 18,
            ),
            const SizedBox(
              width: 4,
            ),
            AppText(
              quantity.toString(),
              color: const Color(0xFF393E67),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.42,
            ),
          ],
        )
      ],
    );
  }

  Widget _boxDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title,
          color: Colors.grey[500],
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.30,
        ),
        const SizedBox(
          height: 8,
        ),
        AppText(
          value,
          color: const Color(0xFF393E67),
          fontWeight: FontWeight.w500,
          fontSize: 14,
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
          if (data.property.fkPropertyType == AppConstants.propertyTypeRent)
            _boxDetailItem(
                'Modalidade de pagamento', data.property.paymentModality),
          // if (data.property.fkPropertyType == AppConstants.propertyTypeRent)
          //   const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _descriptionBlock(String? description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          "Descrição",
          fontWeight: FontWeight.w700,
          color: Color(0xff2c3a61),
        ),
        const SizedBox(height: 20),
        if (description != null && description.isNotEmpty)
          AppText(
            description,
            fontSize: 14,
            color: const Color(0xff2c3a61),
            height: 1.5,
          )
        else
          const AppText(
            'N/I',
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xff2c3a61),
            height: 1.5,
          ),
      ],
    );
  }

  Widget _contactBox(BuildContext context, PropertyResult data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
      decoration: ShapeDecoration(
        color: const Color(0xFFF5F4F8),
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
              AppText(
                data.property.companyEntity.user.email,
                // data['companyEntity']['user']['email'],
                color: const Color(0xFF2C3A61),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.42,
              ),
              const SizedBox(
                height: 4,
              ),
              const AppText(
                'Corretor de imóveis',
                color: Color(0xFF2C3A61),
                fontSize: 12,
                height: 0,
                letterSpacing: 0.27,
              ),
            ],
          ),
          const Row(
            children: [
              Icon(
                Icons.phone,
                color: Color(0xFF393E67),
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.message,
                color: Color(0xFF393E67),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _displayDetail(BuildContext context, PropertyResult data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 180,
                child: AppText(
                  data.property.title,
                  color: const Color(0xFF2C3A61),
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 96,
                child: AppText(
                  AppUtils.formatNumberWithSufix(data.property.price),
                  textAlign: TextAlign.right,
                  color: const Color(0xFF393E67),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
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
                    Icons.location_on_rounded,
                    color: Color(0xFF2C3A61),
                    size: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  AppText(
                    "${data.property.province}, ${data.property.county}",
                    color: const Color(0xFF53577A),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              const AppText(
                'por mês',
                textAlign: TextAlign.right,
                color: Color(0xFF53577A),
                letterSpacing: 0.36,
              ),
            ],
          ),
          const SizedBox(height: 40),
          _boxDetail(context, data),
          if (data.property.description.isNotEmpty) const SizedBox(height: 40),
          if (data.property.description.isNotEmpty)
            _descriptionBlock(data.property.description)
        ],
      ),
    );
  }

  Future<void> _confirmDeletion(
      BuildContext context, String pkProperty, String propertyStatus) async {
    if (propertyStatus == AppConstants.PROPERTY_STATUS['rentend']) {
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Não pode remover um imóvel que já foi arrendado.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );

      return;
    }

    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar'),
          content: const Text('Tem certeza que deseja excluir este imóvel?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );

    if (confirmed ?? false) {
      _deleteProperty(context, pkProperty);
    }
  }

  Future<void> _deleteProperty(BuildContext context, String pkProperty) async {
    setState(() => _isLoading = true);

    try {
      // Aguarda a conclusão da operação deleteProperty
      await Provider.of<PropertyList>(
        context,
        listen: false,
      ).deleteProperty(pkProperty);

      Navigator.of(context).pushNamed(AppRoutes.ANNOUNCEMENT_SCREEN);

      Fluttertoast.showToast(
        msg: "Imóvel removido com sucesso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[700],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Não foi possível remover o imóvel/propriedade.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
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
              _displayDetail(context, data),
              Padding(
                padding: const EdgeInsets.all(16),
                child: _contactBox(context, data),
              ),
              const SizedBox(
                height: 20,
              ),
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Button(
                          title: 'Editar Imóvel',
                          fontSize: 14,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.ANNOUNCEMENT_SCREEN);
                          },
                          variant: ButtonVariant.outlineAlert,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Button(
                          title: 'Exluir Imóvel',
                          fontSize: 14,
                          onPressed: () => _confirmDeletion(
                              context,
                              data.property.pkProperty,
                              data.property.propertyStatus),
                          variant: ButtonVariant.danger,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
