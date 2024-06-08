class Company {
  final String nif;
  final String bankName;
  final String bankAccountNumber;
  final String iban;
  final bool? status;

  Company({
    required this.nif,
    required this.bankName,
    required this.bankAccountNumber,
    required this.iban,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'nif': nif,
      'bankName': bankName,
      'bankAccountNumber': bankAccountNumber,
      'iban': iban,
    };
  }
}
