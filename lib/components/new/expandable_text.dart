import 'package:flutter/material.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class ExpandableText extends StatefulWidget {
  final String title;
  final String description;
  final int maxLines;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  const ExpandableText({
    Key? key,
    required this.title,
    required this.description,
    this.maxLines = 2,
    this.titleStyle,
    this.descriptionStyle,
  }) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: widget.titleStyle ??
              const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedCrossFade(
              firstChild: Text(
                widget.description,
                maxLines: widget.maxLines,
                overflow: TextOverflow.ellipsis,
                style: widget.descriptionStyle ??
                    const TextStyle(
                      fontSize: 16,
                      color: secondaryText,
                    ),
              ),
              secondChild: Text(
                widget.description,
                style: widget.descriptionStyle ??
                    const TextStyle(
                      fontSize: 16,
                      color: secondaryText,
                    ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  isExpanded ? 'Ler menos' : 'Leia mais...',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
