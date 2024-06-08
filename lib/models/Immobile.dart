class Immobile {
  final String id;
  final String title;
  final String location;
  final double price;
  final String type;
  final List<String> images;
  final double? condominiumFree;
  final String? conservation;
  final double? totalArea;
  final double? buildingArea;
  final int? suits;
  final int? room;
  final int? bathrooms;
  final int? vacancyFree;
  final String ownerName;
  final int ownerPhoneNumber;
  final bool isFavorite;
  final String? description;
  final String? paymentMethod;

  Immobile({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.type,
    required this.images,
    required this.ownerName,
    required this.ownerPhoneNumber,
    required this.isFavorite,
    this.condominiumFree,
    this.conservation,
    this.totalArea,
    this.buildingArea,
    this.suits,
    this.room,
    this.bathrooms,
    this.vacancyFree,
    this.description,
    this.paymentMethod,
  });
}
