class AppValidators {
  static bool validatePhoneNumber(String str) {
    if (str.length == 9) return true;
    return false;
  }

  static bool validateField(String str, int length) {
    if (str.isNotEmpty && str.length >= length) return true;
    return false;
  }

  static String? validator(String? value, String message) {
    final v = value ?? '';
    if (v.isEmpty) {
      return message;
    }
    return null;
  }

  static String validateStringFormData(Object? value) {
    if (value != null) return value.toString();
    return '';
  }

  static int validateIntFormData(Object? value) {
    if (value != null) {
      print('int');
      print(value);
      return int.parse(value.toString());
    }
    return 0;
  }

  static double validateDoubleFormData(Object? value) {
    if (value != null) {
      print('double');
      print('$value');
      return double.parse(value.toString());
    }
    return 0;
  }
}
