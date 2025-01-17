import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_form_field.dart';
import 'package:reis_imovel_app/screens/property/components/subtitle_page.dart';
import 'package:reis_imovel_app/screens/property/components/title_page.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/validators/new_apartment_form_validator.dart';

class SecondPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController totalAreaController;

  final TextEditingController roomController;

  final TextEditingController bathroomController;

  final TextEditingController vacancyController;

  final TextEditingController suitsController;

  const SecondPage({
    super.key,
    required this.formKey,
    required this.totalAreaController,
    required this.roomController,
    required this.bathroomController,
    required this.vacancyController,
    required this.suitsController,
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
            const TitlePage(title: 'Características Internas e Externas'),
            const SubtitlePage(
              description:
                  'Por favor adicione as informações das características internas e Externas',
            ),
            const SizedBox(height: 24),
            CustomFormField(
              controller: widget.roomController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              labelText: 'Número de Quartos',
              hintText: 'Digite o número de quartos',
              validator: genericValidator.call,
              // validator: userNameValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.bathroomController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              labelText: 'Número de banheiros',
              hintText: 'Digite o número de banheiros',
              validator: genericValidator.call,
              // validator: userNameValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.suitsController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              labelText: 'Número de Súites',
              hintText: 'Digite o número de súites',
              // validator: userNameValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.totalAreaController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              labelText: 'Área total (m²)',
              hintText: 'Digite a área total',
              helperText: 'Área de construção do imóvel, medido em m².',
              // validator: userNameValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.vacancyController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              labelText: 'Número de vagas',
              hintText: 'Digite o número de vagas',
              helperText:
                  'Número de vagas corresponde ao número de vagas para o estacionamento de carro.',
              // validator: userNameValidator.call,
            ),
          ],
        ),
      ),
    );
  }
}
