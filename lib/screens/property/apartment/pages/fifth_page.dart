import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_dropdown_form_field.dart';
import 'package:reis_imovel_app/components/new/custom_form_field.dart';
import 'package:reis_imovel_app/data/payment_modality_data.dart';
import 'package:reis_imovel_app/screens/property/components/subtitle_page.dart';
import 'package:reis_imovel_app/screens/property/components/title_page.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/validators/new_apartment_form_validator.dart';

class FifthPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController paymentMethodController;

  final TextEditingController priceController;

  final String propertyType;

  const FifthPage({
    super.key,
    required this.formKey,
    required this.paymentMethodController,
    required this.priceController,
    required this.propertyType,
  });

  @override
  State<FifthPage> createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitlePage(title: 'Informações Financeira'),
            const SubtitlePage(
              description:
                  'Por favor preencha os dados das informações financeira.',
            ),
            const SizedBox(height: 24),
            CustomFormField(
              controller: widget.priceController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              labelText: AppConstants.propertyTypeRent == widget.propertyType
                  ? 'Preço de aluguel'
                  : 'Preço da compra',
              helperText: AppConstants.propertyTypeRent == widget.propertyType
                  ? 'O preço do aluguel será multiplicado em função da modalidade de pagamento.'
                  : 'Por favor, insira o preço de compra do imóvel.',
              hintText: '',
              validator: genericValidator.call,
            ),
            if (AppConstants.propertyTypeRent == widget.propertyType)
              const SizedBox(height: defaultPadding),
            if (AppConstants.propertyTypeRent == widget.propertyType)
              CustomDropdownFormField(
                list: payment_modality_data,
                hintText: 'Selecionar a modalidade pagamento',
                labelText: 'Modalidade de pagamento',
                controller: widget.paymentMethodController,
              )
          ],
        ),
      ),
    );
  }
}
