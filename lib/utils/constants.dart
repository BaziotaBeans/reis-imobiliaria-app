import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

const Color primaryColor = Color(0xFF7B61FF);

const Color inactiveMarkerColor = Color(0xFF7B61FF);

const Color activeMarkerColor = Color.fromARGB(255, 85, 51, 255);

const Color bgColor = Color(0xFFFAFAFA);

const Color bgPropertyColor = Color(0xFFF7FAFC);

const Color inactiveColor = Color(0xFFE4E4E4);

const Color tagColor = Color(0xFFF4F4F4);

const Color customRedColor = Color(0xFFE53E3E);

const Color secondaryText = Color(0xFF74778B);

const Color expressColor = Color(0xFFF08524);

const Color expressBoxColor = Color(0xFFEDF2F7);

const Color bgContractCard = Color(0xFFF5F4F8);

const Color alertBoxColor = Color(0xFFFF6400);

const MaterialColor primaryMaterialColor =
    MaterialColor(0xFF9581FF, <int, Color>{
  50: Color(0xFFEFECFF),
  100: Color(0xFFD7D0FF),
  200: Color(0xFFBDB0FF),
  300: Color(0xFFA390FF),
  400: Color(0xFF8F79FF),
  500: Color(0xFF7B61FF),
  600: Color(0xFF7359FF),
  700: Color(0xFF684FFF),
  800: Color(0xFF5E45FF),
  900: Color(0xFF6C56DD),
});

const Color secondaryColor = Color(0xFF1A1B27);

const Color blackColor = Color(0xFF16161E);
const Color blackColor80 = Color(0xFF45454B);
const Color blackColor60 = Color(0xFF737378);
const Color blackColor40 = Color(0xFFA2A2A5);
const Color blackColor20 = Color(0xFFD0D0D2);
const Color blackColor10 = Color(0xFFE8E8E9);
const Color blackColor5 = Color(0xFFF3F3F4);

const Color whiteColor = Colors.white;
const Color whileColor80 = Color(0xFFCCCCCC);
const Color whileColor60 = Color(0xFF999999);
const Color whileColor40 = Color(0xFF666666);
const Color whileColor20 = Color(0xFF333333);
const Color whileColor10 = Color(0xFF191919);
const Color whileColor5 = Color(0xFF0D0D0D);

const Color greyColor = Color(0xFFB8B5C3);
const Color lightGreyColor = Color(0xFFF8F8F9);
const Color darkGreyColor = Color(0xFF1C1C25);
// const Color greyColor80 = Color(0xFFC6C4CF);
// const Color greyColor60 = Color(0xFFD4D3DB);
// const Color greyColor40 = Color(0xFFE3E1E7);
// const Color greyColor20 = Color(0xFFF1F0F3);
// const Color greyColor10 = Color(0xFFF8F8F9);
// const Color greyColor5 = Color(0xFFFBFBFC);

const Color purpleColor = Color(0xFF7B61FF);
const Color successColor = Color(0xFF2ED573);
const Color warningColor = Color(0xFFFFBE21);
const Color errorColor = Color(0xFFE53E3E);

const double defaultPadding = 16.0;
const double defaultBorderRadious = 12.0;
const Duration defaultDuration = Duration(milliseconds: 300);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'A senha é obrigatória'),
  MinLengthValidator(8, errorText: 'a senha deve ter pelo menos 8 dígitos'),
  //PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'O e-mail é obrigatório'),
  EmailValidator(errorText: "Insira um endereço de e-mail válido"),
]);

const pasNotMatchErrorText = "As senhas não coincidem";

final userNameValidator = MultiValidator([
  RequiredValidator(errorText: 'Nome do usuário é obrigatório'),
  MinLengthValidator(5,
      errorText: 'O nome do usuário deve ter pelo menos 5 dígitos'),
]);

final fullNameValidator = MultiValidator([
  RequiredValidator(errorText: 'Nome completo é obrigatório'),
]);

final nifValidator = MultiValidator([
  LengthRangeValidator(
    min: 14,
    max: 14,
    errorText: 'Informe um NIF válido',
  )
]);

final addressValidator = MultiValidator([
  RequiredValidator(errorText: 'Endereço é obrigatório'),
]);

final phoneValidator = MultiValidator([
  RequiredValidator(errorText: 'Número de telefone é obrigatório'),
]);

final bankNameValidator = MultiValidator([
  RequiredValidator(errorText: 'Nome do banco é obrigatório'),
]);

final bankIBANValidator = MultiValidator([
  RequiredValidator(errorText: 'IBAN é obrigatório'),
]);

final bankAccountNumberValidator = MultiValidator([
  RequiredValidator(errorText: 'Número da conta é obrigatório'),
]);
