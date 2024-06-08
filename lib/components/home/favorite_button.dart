import 'package:flutter/material.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFF9F9FA),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Cor da sombra
              spreadRadius: 5, // Raio de propagação da sombra
              blurRadius: 7, // Raio de desfoque da sombra
              offset: Offset(1, 3), // Deslocamento da sombra
            ),
          ],
        ),
        child: Center(
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            size: 20,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
