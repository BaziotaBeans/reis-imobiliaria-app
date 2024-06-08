import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/card_detail_image_slider_item.dart';
import 'package:reis_imovel_app/components/dot_indicators.dart';
import 'package:reis_imovel_app/dto/Image.dart' as dto;
import 'package:reis_imovel_app/utils/app_constants.dart';

class CardDetailImageSlider extends StatefulWidget {
  const CardDetailImageSlider({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<dto.Image> images;

  @override
  State<CardDetailImageSlider> createState() => _CardDetailImageSliderState();
}

class _CardDetailImageSliderState extends State<CardDetailImageSlider> {
  int intialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      // aspectRatio: 1.81,
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (value) {
              setState(() {
                intialIndex = value;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) =>
                CardDetailImageSliderItem(image: widget.images[index].url),
          ),
          if (widget.images.length > 1)
            Positioned(
              bottom: AppConstants.defaultPadding,
              right: AppConstants.defaultPadding,
              child: Row(
                children: List.generate(
                  widget.images.length,
                  (index) => DotIndicator(
                    isActive: intialIndex == index,
                    activeColor: Colors.white,
                    inActiveColor: Colors.white,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
