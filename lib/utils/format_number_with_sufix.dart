import 'dart:math' as math;

String formatNumberWithSufix(double value) {
  List<String> suffixes = ['k', 'M', 'B', 'T'];

  // Se o valor for menor que 1000, não é necessário adicionar sufixo
  if (value < 1000) {
    return value.toString();
  }

  int exp = (math.log(value) / math.log(1000)).floor();
  double result = value / math.pow(1000, exp);

  return result.toStringAsFixed(0) + suffixes[exp - 1];
}
