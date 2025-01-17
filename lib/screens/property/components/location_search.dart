import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/config/map.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class LocationSearch extends StatefulWidget {
  final void Function(String address, String province, String county,
      double latitude, double longitude) onAddAddress;

  const LocationSearch({
    super.key,
    required this.onAddAddress,
  });

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  final MapController mapController = MapController();
  final Dio _dio = Dio();
  Timer? _debounce;
  List<Map<String, dynamic>> _searchResults = [];
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  double _currentZoom = 11.0; // Zoom inicial
  LatLng _currentCenter = defaultInitialLatLng;
  String _selectedProvince = '';
  String _selectedMunicipality = '';
  String _selectedAddress = '';

  @override
  void dispose() {
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
                    'province': item['address']['state'],
                    'county': item['address']['county'],
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

        // debugPrint('####################');
        // debugPrint('${location['position']}');
        // debugPrint('${location['address']['state']}');
        // debugPrint('${location['address']['county']}');
        // debugPrint('${location['display_name']}');
        // debugPrint('####################');

        widget.onAddAddress(
          location['display_name'].split(',').take(2).join(',').trim(),
          location['address']['state'],
          location['address']['county'],
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
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultPadding),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(8),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Colors.black26,
              //     blurRadius: 4,
              //   ),
              // ],
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
                      debugPrint('####################');
                      debugPrint('${selection['position']}');
                      debugPrint('${selection['province']}');
                      debugPrint('${selection['county']}');
                      debugPrint('${selection['name']}');
                      debugPrint('####################');

                      widget.onAddAddress(
                        selection['name'].split(',').take(2).join(',').trim(),
                        selection['province'],
                        selection['county'],
                        selection['position'].latitude,
                        selection['position'].longitude,
                      );
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
          const SizedBox(height: defaultPadding),
          const CustomText(
            'Selecione a localização',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: defaultPadding),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: FlutterMap(
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
                    debugPrint('############');
                    debugPrint('$tapPosition');
                    debugPrint('$point');
                    setState(() => _currentCenter = point);
                  }),
                ),
                children: [
                  TileLayer(
                    urlTemplate: urlTemplateVoyager,
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _currentCenter,
                        child: SvgPicture.asset(
                          "assets/icons/Selected Location.svg",
                          height: 24,
                          width: 24,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          CustomButton(
            text: 'Salvar enderço',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
