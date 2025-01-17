import 'package:form_field_validator/form_field_validator.dart';

final titleValidator = MultiValidator([
  RequiredValidator(errorText: 'Título/Nome é obrigatório'),
]);

final genericValidator = MultiValidator([
  RequiredValidator(errorText: 'Campo é obrigatório'),
]);

String validateStringFormData(String value) {
  print('###########################');
  print('VER VALOR: $value');
  print('VER VALOR: ${value.isEmpty}');
  print('###########################');
  if (value.isNotEmpty && value != null) return value.toString();
  return '';
}

int validateIntFormData(String value) {
  if (value.isNotEmpty && value != null) {
    print('int');
    print(value);
    return int.parse(value.toString());
  }
  return 0;
}

double validateDoubleFormData(String value) {
  if (value.isNotEmpty && value != null) {
    print('double');
    print('$value');
    return double.parse(value.toString());
  }
  return 0;
}
