import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/Image.dart' as PropertyImage;
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/config/map.dart';
import 'package:reis_imovel_app/dto/Property.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/models/PropertyList.dart';
import 'package:reis_imovel_app/screens/explore/components/marker_widget.dart';
import 'package:reis_imovel_app/screens/explore/components/property_card_result.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final MapController mapController = MapController();
  final Dio _dio = Dio();
  Timer? _debounce; // Timer para gerenciar o debounce
  List<Map<String, dynamic>> _searchResults = [];
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = false; // Variável para gerenciar o estado de carregamento

  Property? selectedProperty;
  PropertyResult? selectedPropertyResult;
  List<PropertyImage.Image>? selectedPropertyImage;

  double _currentZoom = 11.0; // Zoom inicial
  LatLng _currentCenter = defaultInitialLatLng;

  bool showForSale = true;
  bool showForRent = true;
  double maxPrice = maxPriceFilter;

  @override
  void initState() {
    super.initState();
    Provider.of<PropertyList>(
      context,
      listen: false,
    ).loadPublicProperties();
  }

  @override
  void dispose() {
    // _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _fetchLocations(String query) async {
    setState(() {
      _isLoading = true; // Exibe o loader
    });
    try {
      final response = await _dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {
          'q': query,
          'countrycodes': 'AO', // Limita a busca para Angola
          'format': 'json',
          'addressdetails': 1,
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          _searchResults = (response.data as List)
              .map((item) => {
                    'name': item['display_name'],
                    'position': LatLng(
                      double.parse(item['lat']),
                      double.parse(item['lon']),
                    ),
                  })
              .toList();
        });
      }
    } catch (e) {
      debugPrint('Erro ao buscar localizações: $e');
    } finally {
      setState(() {
        _isLoading = false; // Esconde o loader
      });
    }
  }

  Future<void> _moveToRegion(String query) async {
    try {
      final response = await _dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {
          'q': query,
          'countrycodes': 'AO', // Limita a busca para Angola
          'format': 'json',
          'addressdetails': 1,
        },
      );
      if (response.statusCode == 200 && response.data.isNotEmpty) {
        final location = response.data[0];
        final LatLng position = LatLng(
          double.parse(location['lat']),
          double.parse(location['lon']),
        );

        setState(() {
          _currentCenter = position;
        });
        mapController.move(_currentCenter, _currentZoom);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Localização não encontrada.'),
          ),
        );
      }
    } catch (e) {
      debugPrint('Erro ao mover para a região: $e');
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        _fetchLocations(query);
      }
    });
  }

  void _onSubmitted(String query) {
    // Procura no _searchResults por um item correspondente
    final matchingOption = _searchResults.firstWhere(
      (location) =>
          location['name'].toString().toLowerCase() == query.toLowerCase(),
      orElse: () => <String, dynamic>{}, // Retorna um mapa vazio
    );

    if (matchingOption.isNotEmpty) {
      // Se encontrar no Autocomplete, mover o mapa para essa posição
      setState(() {
        _currentCenter = matchingOption['position'];
      });
      mapController.move(_currentCenter, _currentZoom);
    } else {
      // Caso contrário, fazer uma nova requisição para tentar encontrar a região
      _moveToRegion(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final PropertyList publicProperties = Provider.of(context);

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: _currentCenter, // Coordenadas de Luanda
              initialZoom: _currentZoom,
              maxZoom: maxZoom,
              minZoom: minZoom,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
              onTap: (tapPosition, point) => setState(() {
                selectedProperty = null;
                selectedPropertyImage = null;
                selectedPropertyResult = null;
              }),
              onPositionChanged: (position, hasGesture) {
                // Atualize o centro quando a posição mudar
                setState(() {
                  _currentCenter = position.center!;
                });
              },
            ),
            children: [
              TileLayer(
                tileProvider: CancellableNetworkTileProvider(),
                urlTemplate: urlTemplateVoyager,
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: publicProperties.propertiesPublic
                    .where((p) => _matchesFilters(p.property))
                    .map(
                      (property) => Marker(
                        width: 35,
                        height: 35,
                        point: LatLng(property.property.latitude ?? 0,
                            property.property.longitude ?? 0),
                        child: MarkerWidget(
                          isSelected: property.property.pkProperty ==
                              selectedProperty?.pkProperty,
                          onTap: () => {
                            setState(() {
                              selectedProperty = property.property;
                              selectedPropertyImage = property.images;
                              selectedPropertyResult = property;
                            })
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          Positioned(
            bottom: 146,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  backgroundColor: whiteColor,
                  heroTag: "zoomInButton",
                  mini: true,
                  onPressed: () {
                    setState(() {
                      _currentZoom += 1;
                      mapController.move(_currentCenter, _currentZoom);
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  backgroundColor: whiteColor,
                  heroTag: "zoomOutButton",
                  mini: true,
                  onPressed: () {
                    setState(() {
                      _currentZoom -= 1;
                      mapController.move(_currentCenter, _currentZoom);
                    });
                  },
                  child: const Icon(
                    Icons.minimize,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          // Barra de pesquisa
          Positioned(
            top: 20,
            left: 16,
            right: 16,
            child: Container(
              height: 60,
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
              child: Center(
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Autocomplete<Map<String, dynamic>>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<Map<String, dynamic>>.empty();
                        }
                        _onSearchChanged(textEditingValue.text);
                        return _searchResults;
                      },
                      displayStringForOption: (Map<String, dynamic> option) =>
                          option['name'],
                      fieldViewBuilder:
                          (context, controller, focusNode, onFieldSubmitted) {
                        _searchController = controller;
                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          onChanged: _onSearchChanged,
                          onSubmitted: _onSubmitted, // Adicionado aqui
                          decoration: const InputDecoration(
                            hintText: 'Pesquisar localização...',
                            border: InputBorder.none,
                            icon: Icon(Icons.search),
                          ),
                        );
                      },
                      onSelected: (Map<String, dynamic> selection) {
                        setState(() {
                          _currentCenter = selection['position'];
                        });
                        mapController.move(_currentCenter, _currentZoom);
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            color: Colors.white,
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 64,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final option = options.elementAt(index);
                                  return ListTile(
                                    title: Text(option['name']),
                                    onTap: () => onSelected(option),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    if (_isLoading)
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Painel de filtros
          Positioned(
            top: 100,
            right: 16,
            child: SizedBox(
              width: 250, // Define uma largura fixa para o painel de filtros
              child: Card(
                color: whiteColor,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CheckboxListTile(
                        activeColor: Theme.of(context).primaryColor,
                        title: const CustomText('Venda'),
                        value: showForSale,
                        dense: true,
                        onChanged: (value) =>
                            setState(() => showForSale = value ?? showForSale),
                      ),
                      CheckboxListTile(
                        activeColor: Theme.of(context).primaryColor,
                        title: const Text('Aluguel'),
                        value: showForRent,
                        onChanged: (value) =>
                            setState(() => showForRent = value ?? showForRent),
                      ),
                      Slider(
                        thumbColor: primaryColor,
                        activeColor: primaryColor,
                        value: maxPrice,
                        max: maxPriceFilter,
                        divisions: 100000,
                        label: '${maxPrice.toStringAsFixed(2)} Kz',
                        onChanged: (value) => setState(() => maxPrice = value),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Card do imóvel selecionado
          if (selectedProperty != null &&
              selectedPropertyImage != null &&
              selectedPropertyResult != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: PropertyCardResult(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.IMMOBILE_DETAIL_SCREEN,
                    arguments: selectedPropertyResult,
                  );
                },
                data: selectedProperty!,
                imgUrl: selectedPropertyImage![0].url,
              ),
            ),
        ],
      ),
    );
  }

  bool _matchesFilters(Property property) {
    return ((property.fkPropertyTypeEntity.designation == 'Terreno' &&
                showForSale) ||
            (property.fkPropertyTypeEntity.designation == 'Venda' &&
                showForSale) ||
            (property.fkPropertyTypeEntity.designation == 'Arrendamento' &&
                showForRent)) &&
        property.price <= maxPrice;
  }
}
