class Image {
  final String pkImage;
  final String url;
  final List<dynamic> properties; // Aqui seria ideal definir uma classe específica se tivéssemos mais detalhes

  Image({
    required this.pkImage,
    required this.url,
    required this.properties,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      pkImage: json['pkImage'],
      url: json['url'],
      properties: json['properties'], // Isso assume que `properties` é uma lista de propriedades desconhecidas ou não especificadas
    );
  }
}
