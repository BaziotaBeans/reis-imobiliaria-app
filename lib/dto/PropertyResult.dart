import 'package:reis_imovel_app/dto/Image.dart';
import 'package:reis_imovel_app/dto/Property.dart';

class PropertyResult {
  final Property property;
  final List<Image> images;
  final dynamic schedules; // Pode ser `null` ou uma lista de agendamentos.

  PropertyResult({
    required this.property,
    required this.images,
    this.schedules,
  });

  factory PropertyResult.fromJson(Map<String, dynamic> json) {
    return PropertyResult(
      property: Property.fromJson(json['property']),
      images: (json['images'] as List).map((i) => Image.fromJson(i)).toList(),
      schedules: json['schedules'],
    );
  }
}
