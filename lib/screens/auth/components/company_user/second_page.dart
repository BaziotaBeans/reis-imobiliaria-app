import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:reis_imovel_app/components/new/custom_dropdown_form_field.dart';
import 'package:reis_imovel_app/components/new/custom_form_field.dart';
import 'package:reis_imovel_app/data/marital_status_data.dart';
import 'package:reis_imovel_app/data/nationality_data.dart';
import 'package:reis_imovel_app/screens/auth/components/subtitle_form.dart';
import 'package:reis_imovel_app/screens/auth/components/title_form.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class SecondPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController fullNameController;

  final TextEditingController nifController;

  final TextEditingController phoneController;

  final TextEditingController addressController;

  final TextEditingController nationalityController;

  final TextEditingController maritalStatusController;

  const SecondPage({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.nifController,
    required this.phoneController,
    required this.addressController,
    required this.nationalityController,
    required this.maritalStatusController,
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
            const TitleForm(title: 'Dados do Imobiliário'),
            const SubtitleForm(description: 'Preencha os dados do imobiliário'),
            const SizedBox(height: 44),
            CustomFormField(
              controller: widget.fullNameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'Primeiro e último nome',
              hintText: 'Digite o primeiro e último nome',
              validator: fullNameValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.nifController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'NIF',
              hintText: 'Digite o NIF',
              helperText:
                  'O NIF (Número de identificação Fiscal) deve possuir 14 caracteres',
              validator: nifValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            IntlPhoneField(
              languageCode: 'ao',
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Número de telefone',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'AO',
              // onSaved: (phone) => _formData['phone'] = phone?.number ?? '',
              // onChanged: (phone) {
              //   _formKey.currentState?.validate();
              //   validateSubmitButton();
              //   _formData['phone'] = phone.number;
              // },
              // validator: phoneValidator.call,
              controller: widget.phoneController,
              pickerDialogStyle: PickerDialogStyle(
                searchFieldInputDecoration:
                    const InputDecoration(labelText: 'Pesquisar País'),
              ),
              invalidNumberMessage: 'Informe um contacto válido',
            ),
            const SizedBox(height: defaultPadding),
            CustomFormField(
              controller: widget.addressController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              labelText: 'Endereço',
              hintText: 'Digite o endereço',
              validator: addressValidator.call,
            ),
            const SizedBox(height: defaultPadding),
            CustomDropdownFormField(
              controller: widget.nationalityController,
              list: nationalities,
              enableFilter: true,
              enableSearch: true,
              labelText: 'Nacionalidade',
              helperText:
                  "A nacionalidade é um campo obrigatório, pois será usado no acto da realização do contrato.",
              hintText: 'Selecionar a nacionalidade',

              // widthValueOfPadding: widthValueOfPadding,
            ),
            const SizedBox(height: defaultPadding),
            CustomDropdownFormField(
              controller: widget.maritalStatusController,
              list: maritalStatusData,
              enableFilter: true,
              enableSearch: true,
              labelText: 'Estado civil',
              helperText:
                  "O estado civil é um campo obrigatório, pois será usado no acto da realização do contracto.",
              hintText: 'Selecionar o estado civil',

              // widthValueOfPadding: widthValueOfPadding,
            ),
          ],
        ),
      ),
    );
  }
}
