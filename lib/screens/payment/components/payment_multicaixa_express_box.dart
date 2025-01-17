import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:reis_imovel_app/components/new/custom_form_field.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/screens/payment/components/payment_countdown_progress_bar.dart';
import 'package:reis_imovel_app/utils/constants.dart';
import 'package:reis_imovel_app/validators/angola_phone_validator.dart';

class PaymentMulticaixaExpressBox extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final String expirationDate;

  final Function() onExpired;

  final Function() onInputChange;

  final TextEditingController phoneNumberController;

  const PaymentMulticaixaExpressBox({
    super.key,
    required this.formKey,
    required this.phoneNumberController,
    required this.expirationDate,
    required this.onExpired,
    required this.onInputChange,
  });

  @override
  State<PaymentMulticaixaExpressBox> createState() =>
      _PaymentMulticaixaExpressBoxState();
}

class _PaymentMulticaixaExpressBoxState
    extends State<PaymentMulticaixaExpressBox> {
  Widget _builtHeaderLine() {
    return Container(
      width: 65,
      height: 10,
      decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius:
              BorderRadius.all(Radius.circular(defaultBorderRadious))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 24, bottom: 24),
        decoration: BoxDecoration(
          color: expressBoxColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _builtHeaderLine(),
            const SizedBox(height: defaultPadding),
            const Divider(
              color: whiteColor,
              thickness: 6,
            ),
            const SizedBox(height: defaultPadding),
            PaymentCountdownProgressBar(
              size: 54,
              expirationDate: widget.expirationDate,
              onExpired: widget.onExpired,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    'Número de telefone',
                    color: Color(0xFF74778B),
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    controller: widget.phoneNumberController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onChanged: (val) {
                      widget.onInputChange();
                    },
                    // labelText: 'NIF',
                    hintText: 'Digite o número de telefone',
                    // helperText:
                    //     'O NIF (Número de identificação Fiscal) deve possuir 14 caracteres',
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Este campo é obrigatório'),
                      AngolaPhoneValidator(
                        errorText: 'Número de telefone inválido.',
                      ),
                    ]),
                  ),
                  // TextFormField(
                  //   controller: widget.phoneNumberController,
                  //   keyboardType: TextInputType.phone,
                  //   validator: AngolaPhoneValidator(
                  //     errorText: 'Digite um número de telefone válido.',
                  //   ),
                  //   decoration: const InputDecoration(
                  //     hintText: 'Digite o número de telefone',
                  //     hintStyle: TextStyle(
                  //       color: Color(0xFFA0AEC0),
                  //       fontSize: 16,
                  //     ),
                  //     border: InputBorder.none,
                  //     contentPadding: EdgeInsets.only(
                  //         left: defaultPadding, right: defaultPadding),
                  //   ),
                  //   style: const TextStyle(
                  //     fontSize: 16,
                  //     color: Colors.black87,
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
