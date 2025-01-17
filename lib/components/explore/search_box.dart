import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/dto/PropertyTypeEntity.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class SearchBox extends StatefulWidget {
  final List<PropertyTypeEntity> propertyTypes;
  final void Function(String value) onChangeTextField;
  final void Function(String value) onChangeDropdownButtonFormField;

  const SearchBox(
      {required this.propertyTypes,
      required this.onChangeTextField,
      required this.onChangeDropdownButtonFormField,
      super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  Widget _content() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Provínicia, Municipio, Endereço',
              hintStyle: TextStyle(
                color: Color(0xFF3D3F33),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Icon(
                Icons.location_on_outlined,
                color: primaryColor,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 2,
                ),
              ),
            ),
            onChanged: (value) {
              widget.onChangeTextField(value);
            },
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              // labelText: 'Type 3A',
              hintText: 'Selecione o tipo de imóvel',
              hintStyle: TextStyle(
                color: Color(0xFF3D3F33),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.maps_home_work_outlined,
                color: Color(0xfff687553),
              ),
            ),
            items: widget.propertyTypes.map((type) {
              return DropdownMenuItem<String>(
                value: type.pkPropertyType,
                child: Text(type.designation),
              );
            }).toList(),
            onChanged: (String? newValue) {
              widget.onChangeDropdownButtonFormField(newValue!);
            },
          ),
          const SizedBox(height: 10),
          Button(
            title: 'Pesquisar',
            onPressed: () {},
            variant: ButtonVariant.primary,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _content(),
        ],
      ),
    );
  }
}
