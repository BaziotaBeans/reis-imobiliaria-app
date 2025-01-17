import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:reis_imovel_app/dto/Property.dart';

// class Property {
//   final String title;
//   final String address;
//   final double price;
//   final String imageUrl;
//   final LatLng location;
//   final bool isForSale;
//   final bool isForRent;

//   Property({
//     required this.title,
//     required this.address,
//     required this.price,
//     required this.imageUrl,
//     required this.location,
//     required this.isForSale,
//     required this.isForRent,
//   });
// }

class PropertyCard extends StatelessWidget {
  final Property property;
  // final List<Property> nearbyProperties;

  const PropertyCard({
    required this.property,
    // required this.nearbyProperties,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Image.network(property.propertyImages[0]),
            title: Text(property.title),
            subtitle: Text(
              'R\$ ${property.price.toStringAsFixed(2)} - ${property.address}',
            ),
          ),
          // if (nearbyProperties.isNotEmpty)
          //   Container(
          //     height: 120,
          //     child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: nearbyProperties.length,
          //       itemBuilder: (context, index) {
          //         final nearbyProperty = nearbyProperties[index];
          //         return Padding(
          //           padding: EdgeInsets.all(8),
          //           child: Column(
          //             children: [
          //               Image.network(
          //                 nearbyProperty.imageUrl,
          //                 height: 80,
          //                 width: 80,
          //                 fit: BoxFit.cover,
          //               ),
          //               Text(
          //                 'R\$ ${nearbyProperty.price.toStringAsFixed(2)}',
          //                 style: TextStyle(fontSize: 12),
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //     ),
          //   ),
        ],
      ),
    );
  }
}
