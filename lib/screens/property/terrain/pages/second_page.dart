import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reis_imovel_app/components/new/custom_form_field.dart';
import 'package:reis_imovel_app/components/new/custom_modal_bottom_sheet.dart';
import 'package:reis_imovel_app/screens/property/components/location_search.dart';
import 'package:reis_imovel_app/screens/property/components/subtitle_page.dart';
import 'package:reis_imovel_app/screens/property/components/title_page.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/validators/new_apartment_form_validator.dart';

class SecondPage extends StatefulWidget {
  final void Function(String address, String province, String county,
      double latitude, double longitude) onAddAddress;

  final TextEditingController provinceController;

  final TextEditingController countyController;

  final TextEditingController addressController;

  final TextEditingController latitudeController;

  final TextEditingController longitudeController;

  final GlobalKey<FormState> formKey;

  const SecondPage({
    super.key,
    required this.formKey,
    required this.provinceController,
    required this.countyController,
    required this.addressController,
    required this.onAddAddress,
    required this.latitudeController,
    required this.longitudeController,
  });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitlePage(title: 'Localização'),
            const SubtitlePage(
              description:
                  'Por favor selecione a localização do imóvel, essa localização será exibida no momento da pesquisa no mapa automaticamente.',
            ),
            const SizedBox(height: 24),
            CustomFormField(
              controller: widget.addressController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'Endereço',
              hintText: 'Selecione o endereço',
              validator: genericValidator.call,
              helperText:
                  'Selecione o campo endereço para exibir o mapa e completar os restantes dos campos.',
              onTap: () {
                customModalBottomSheet(
                  context,
                  color: whiteColor,
                  child: LocationSearch(
                    onAddAddress: widget.onAddAddress,
                  ),
                );
              },
              suffixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: SvgPicture.asset(
                  "assets/icons/Current Location.svg",
                  height: 24,
                  width: 24,
                ),
              ),
              // validator: userNameValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.provinceController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'Provincia',
              hintText: '',
              readOnly: true,
              validator: genericValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.countyController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'Município',
              hintText: '',
              readOnly: true,
              onChanged: null,
              validator: genericValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.latitudeController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              labelText: 'Latitude',
              hintText: '',
              readOnly: true,
              onChanged: null,
              validator: genericValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.longitudeController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              labelText: 'Longitude',
              hintText: '',
              readOnly: true,
              onChanged: null,
              validator: genericValidator.call,
            ),
          ],
        ),
      ),
    );
  }
}
