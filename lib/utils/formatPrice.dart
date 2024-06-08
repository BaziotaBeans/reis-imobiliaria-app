 import 'package:intl/intl.dart';

String formatPrice(double price) {
    final formatter = NumberFormat.currency(
      locale: 'pt_PT',
      symbol: 'kz',
      decimalDigits: 2,
    );
    return formatter.format(price);
  }