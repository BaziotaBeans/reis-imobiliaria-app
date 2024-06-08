import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/horizontal_space.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center, 
      children: [
        Expanded(
          child: SizedBox(
            height: 64,
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0x14747480),
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Icon(
                    Icons.search,
                    color: Color(0x993C3C43),
                    size: 24,
                  ),
                ),
                hintText: 'Pesquisar Imóveis',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0x14747480),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0x14747480),
                  ),
                ),
              ),
            ),
          ),
        ),
        HorizontalSpace(
          value: 16.0,
          ctx: context,
        ),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(30),
          child: const Icon(
              Icons.filter_list,
              color: Color(0xFF1886F9),
            ),
        ),
      ],
    );
  }
}
