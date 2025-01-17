import 'package:latlong2/latlong.dart';

// Modelo de dados
class Property {
  final String title;
  final String address;
  final double price;
  final String imageUrl;
  final LatLng location;
  final bool isForSale;
  final bool isForRent;

  Property({
    required this.title,
    required this.address,
    required this.price,
    required this.imageUrl,
    required this.location,
    required this.isForSale,
    required this.isForRent,
  });
}
