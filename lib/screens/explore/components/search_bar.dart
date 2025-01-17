import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Pesquisar localização...',
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
        onSubmitted: (value) {
          // Implementar pesquisa de localização
        },
      ),
    );
  }
}
