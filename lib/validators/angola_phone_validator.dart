import 'package:form_field_validator/form_field_validator.dart';

class AngolaPhoneValidator extends TextFieldValidator {
  // Mensagem de erro personalizada
  AngolaPhoneValidator({String errorText = 'Número de telefone inválido'})
      : super(errorText);

  @override
  bool isValid(String? value) {
    // Se o campo for nulo ou vazio, retorna falso
    if (value == null || value.trim().isEmpty) {
      return false;
    }

    // Verifica se o número tem exatamente 9 dígitos e começa com um prefixo válido
    final regex = RegExp(r'^(91|92|93|94|99|22|23)\d{7}$');
    return regex.hasMatch(value);
  }
}
