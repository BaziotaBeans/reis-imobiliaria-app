import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_dropdown_form_field.dart';
import 'package:reis_imovel_app/components/new/custom_form_field.dart';
import 'package:reis_imovel_app/data/bank_list.dart';
import 'package:reis_imovel_app/screens/auth/components/title_form.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class ThirdPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController bankNameController;

  final TextEditingController bankAccountNumberController;

  final TextEditingController bankIBANController;

  const ThirdPage({
    super.key,
    required this.formKey,
    required this.bankNameController,
    required this.bankAccountNumberController,
    required this.bankIBANController,
  });

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleForm(title: 'Dados bancários'),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text:
                          'Preencha os dados bancários, esses dados serão usados no processo da transação, ',
                      children: [
                        TextSpan(
                          text: 'clique aqui. ',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {print('yes')},
                        ),
                        TextSpan(text: 'para saber mais.')
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 44),
            CustomFormField(
              controller: widget.bankIBANController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'IBAN',
              hintText: 'AO06 (---)(---)(-----------)',
              helperText:
                  'IBAN deve possuir 21 algarismos do Número Bancário de Angola.',
              validator: bankIBANValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.bankAccountNumberController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'Digite o número da conta',
              hintText: 'Digite o número da conta',
              validator: bankNameValidator.call,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            CustomDropdownFormField(
              controller: widget.bankNameController,
              labelText: 'Banco',
              list: bankList,
              widthValueOfPadding: 10,
            )
          ],
        ),
      ),
    );
  }
}
