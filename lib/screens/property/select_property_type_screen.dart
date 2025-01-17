import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/screens/property/components/property_announcemnet_type_selector.dart';
import 'package:reis_imovel_app/screens/property/components/property_type_selector.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class SelectPropertyTypeScreen extends StatefulWidget {
  const SelectPropertyTypeScreen({super.key});

  @override
  State<SelectPropertyTypeScreen> createState() =>
      _SelectPropertyTypeScreenState();
}

class _SelectPropertyTypeScreenState extends State<SelectPropertyTypeScreen> {
  String _selectedAnnouncementType = "SALE";
  String _selectedPropertyType = "APARTMENT";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'Adicionar Imóvel',
          fontSize: 16,
          color: secondaryColor,
        ),
        centerTitle: true,
      ),
      backgroundColor: bgPropertyColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24,
            bottom: defaultPadding,
            left: defaultPadding,
            right: defaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                'Finalidade',
                color: secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              const CustomText(
                'Selecione a finalidade do imóvel.',
                color: secondaryText,
                fontSize: 16,
              ),
              const SizedBox(height: 24),
              PropertyAnnouncementTypeSelector(
                onAnnouncementType: (String type) {
                  setState(() {
                    _selectedAnnouncementType = type;
                  });
                },
              ),
              const SizedBox(height: 24),
              const CustomText(
                'Tipo de imóvel',
                color: secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              const CustomText(
                'Selecione o tipo de imóvel que deseja anunciar.',
                color: secondaryText,
                fontSize: 16,
              ),
              const SizedBox(height: 24),
              PropertyTypeSelector(
                selectedAnnouncementType: _selectedAnnouncementType,
                onPropertyType: (String type) {
                  setState(() {
                    _selectedPropertyType = type;
                  });
                },
              ),
              const Expanded(child: SizedBox()),
              CustomButton(
                text: 'Próximo',
                onPressed: () {
                  if (_selectedAnnouncementType == 'RENT' &&
                      (_selectedPropertyType == 'APARTMENT' ||
                          _selectedPropertyType == 'HOME' ||
                          _selectedPropertyType == 'VILLA')) {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.NEW_APARTMENT_SCREEN,
                      arguments: AppConstants.propertyTypeRent,
                    );
                  }
                  if (_selectedAnnouncementType == 'SALE' &&
                      _selectedPropertyType == 'TERRAIN') {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.NEW_TERRAIN_SCREEN,
                      arguments: AppConstants.propertyTypeGround,
                    );
                  }
                  if (_selectedAnnouncementType == 'SALE' &&
                      (_selectedPropertyType == 'APARTMENT' ||
                          _selectedPropertyType == 'HOME' ||
                          _selectedPropertyType == 'VILLA')) {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.NEW_APARTMENT_SCREEN,
                      arguments: AppConstants.propertyTypeSale,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
