class Client {
  final String nif;
  final bool? status;

  Client({
    required this.nif,
    this.status
  });

  Map<String, dynamic> toJson() {
    return {
      'nif': nif,
    };
  }
}