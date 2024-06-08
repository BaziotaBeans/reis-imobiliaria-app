import 'package:flutter/material.dart';

class CardDetailImageSliderItem extends StatelessWidget {
    const CardDetailImageSliderItem({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // borderRadius: const BorderRadius.all(Radius.circular(12)),
        image: DecorationImage(
          // for newtowk image use NetworkImage()
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

