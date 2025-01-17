import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_dropdown_form_field.dart';
import 'package:reis_imovel_app/components/new/custom_form_field.dart';
import 'package:reis_imovel_app/data/payment_modality_data.dart';
import 'package:reis_imovel_app/screens/property/components/subtitle_page.dart';
import 'package:reis_imovel_app/screens/property/components/title_page.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/validators/new_apartment_form_validator.dart';

class FourthPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController priceController;

  const FourthPage({
    super.key,
    required this.formKey,
    required this.priceController,
  });

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
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
              labelText: 'Preço da compra',
              hintText: '',
              validator: genericValidator.call,
            ),
          ],
        ),
      ),
    );
  }
}
