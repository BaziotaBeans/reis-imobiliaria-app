import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/explore/search_box.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/components/home/card_result.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/models/PropertyList.dart';

class ResultSearchScreen extends StatefulWidget {
  const ResultSearchScreen({super.key});

  @override
  State<ResultSearchScreen> createState() => _ResultSearchScreenState();
}

class _ResultSearchScreenState extends State<ResultSearchScreen> {
  String _searchText = "";
  String? _selectedPropertyType;
  List<PropertyResult> _filteredProperties = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PropertyList>(context, listen: false).loadPropertyTypes());
    Future.microtask(() => Provider.of<PropertyList>(context, listen: false)
        .loadPublicProperties());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Este callback é chamado após a árvore de widgets ser construída.
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      setState(() {
        _searchText = routeArgs['searchText'];
        _selectedPropertyType = routeArgs['selectedPropertyType'];
      });
      // Aqui você pode chamar outro método que necessita dos argumentos.
      filterProperties();
    });
  }

  void filterProperties() {
    final properties =
        Provider.of<PropertyList>(context, listen: false).propertiesPublic;
    setState(() {
      _filteredProperties = properties.where((property) {
        final matchesType = _selectedPropertyType == null ||
            property.property.fkPropertyType == _selectedPropertyType;
        final matchesText = _searchText.isEmpty ||
            property.property.county
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
            property.property.province
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
            property.property.address
                .toLowerCase()
                .contains(_searchText.toLowerCase());
        return matchesType && matchesText;
      }).toList();
    });
  }

  void onChangeTextField(String value) {
    setState(() {
      _searchText = value;
    });

    filterProperties();
  }

  void onChangeDropdownButtonFormField(String value) {
    setState(() {
      _selectedPropertyType = value;
    });

    filterProperties();
  }

  Widget _resultSearch(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: _filteredProperties.length,
        itemBuilder: (BuildContext context, int index) {
          return CardResult(
              data: _filteredProperties[index]); //CardImmobileHorizontal();
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    // Acessando os valores dos argumentos
    String searchText = routeArgs['searchText'];
    String selectedPropertyType = routeArgs['selectedPropertyType'];

    final PropertyList properties = Provider.of(context);

    print(routeArgs);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: 'Pesquisas'),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchBox(
                      onChangeDropdownButtonFormField:
                          onChangeDropdownButtonFormField,
                      onChangeTextField: onChangeTextField,
                      propertyTypes: properties.propertyTypes,
                    ),
                    const SizedBox(height: 24),
                    AppText(
                      "Resultado das pesquisas (${_filteredProperties.length})",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xfff3D3F33),
                    ),
                    _resultSearch(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
