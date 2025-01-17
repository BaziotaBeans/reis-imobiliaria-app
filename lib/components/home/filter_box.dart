import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/dto/PropertyTypeEntity.dart';
import 'package:reis_imovel_app/models/PropertyList.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class FilterBox extends StatefulWidget {
  const FilterBox({super.key});

  @override
  State<FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  String _searchText = "";
  String? _selectedPropertyType;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<PropertyList>(context, listen: false).loadPropertyTypes(),
    );
  }

  Widget _header() {
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.only(left: 16),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "Novos Imóveis!",
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              AppText(
                "Casas e terrenos!",
                color: Colors.white,
                fontSize: 16,
              ),
            ],
          ),
          Image(
            image: AssetImage("assets/images/unsplash_home.png"),
            fit: BoxFit.cover,
            width: 130,
          )
        ],
      ),
    );
  }

  Widget _body(List<PropertyTypeEntity> data) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Provínicia, Municipio, Endereço',
                hintStyle: TextStyle(
                  color: Color(0xFFA3A2A9),
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
                setState(() {
                  _searchText = value;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              dropdownColor: whiteColor,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: primaryColor,
                backgroundColor: Colors.white,
              ),
              decoration: const InputDecoration(
                // labelText: 'Type 3A',
                hintText: 'Selecione o tipo de imóvel',
                hintStyle: TextStyle(
                  color: Color(0xFFA3A2A9),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.maps_home_work_outlined,
                  color: primaryColor,
                ),
              ),
              items: data.map((type) {
                return DropdownMenuItem<String>(
                  value: type.pkPropertyType,
                  child: Text(type.designation),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPropertyType = newValue ?? "";
                });
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Pesquisar',
              onPressed: _searchText.isEmpty || _selectedPropertyType == null
                  ? null
                  : () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.RESULT_SEARCH_SCREEN,
                        arguments: {
                          "searchText": _searchText,
                          "selectedPropertyType": _selectedPropertyType
                        },
                      );
                    },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PropertyList properties = Provider.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            _body(properties.propertyTypes),
          ],
        ),
      ),
    );
  }
}
