import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';

class AppPhoneFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? helperText;

  const AppPhoneFormField({
    required this.controller,
    super.key,
    this.labelText,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null && helperText == null)
            AppText(
              labelText ?? '',
              color: Colors.grey[600],
              fontSize: 14,
            ),
          if (labelText != null && helperText != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  labelText ?? '',
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidCircleQuestion,
                      size: 16,
                      color: Color(0xff687553),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: AppText(
                        helperText ?? '',
                        color: Colors.grey[600],
                        fontSize: 12,
                        maxLines: 4,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],
            ),
          IntlPhoneField(
            languageCode: 'ao',
            decoration: const InputDecoration(
              labelText: 'Número de telefone',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff687553),
                  width: 2,
                ),
              ),
              fillColor: Color(0xff687553),
              filled: true,
              focusColor: Color(0xff687553),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff687553),
                  width: 2,
                ),
              ),
            ),
            initialCountryCode: 'AO',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
            pickerDialogStyle: PickerDialogStyle(
              searchFieldInputDecoration: const InputDecoration(
                // hintText: 'Pesquisar País',
                labelText: 'Pesquisar País',
                fillColor: Color(0xff687553),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


          // AppTextFormField(
          //   hintText: 'Telefone',
          //   textInputAction: TextInputAction.next,
          //   keyboardType: TextInputType.phone,
          //   onSaved: (phone) => _signUpClientData['phone'] = phone ?? '',
          //   onChanged: (value) {
          //     _formKey.currentState?.validate();
          //     validateSubmitButton();
          //   },
          //   validator: (phone) {
          //     final phoneNumber = phone ?? '';
          //     if (phoneNumber.isEmpty || !(phoneNumber.length == 9)) {
          //       return 'Informe um contacto válido';
          //     }
          //     return null;
          //   },
          //   controller: _phoneController,
          // ),