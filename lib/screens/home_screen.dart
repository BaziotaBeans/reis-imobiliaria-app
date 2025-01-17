import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/home/filter_box.dart';
import 'package:reis_imovel_app/components/home/for_sale.dart';
import 'package:reis_imovel_app/components/home/latest_announcements.dart';
import 'package:reis_imovel_app/components/home/welcome_area.dart';
import 'package:reis_imovel_app/models/PropertyList.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future? _loadPublicProperties;

  @override
  void initState() {
    super.initState();
    _loadPublicProperties = Provider.of<PropertyList>(
      context,
      listen: false,
    ).loadPublicProperties();
  }

  Future<void> _refreshProperties(BuildContext context) async {
    setState(() {
      _loadPublicProperties = Provider.of<PropertyList>(
        context,
        listen: false,
      ).loadPublicProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    final PropertyList properties = Provider.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFF9F9F9),
      body: RefreshIndicator(
        onRefresh: () => _refreshProperties(context),
        child: SafeArea(
          child: FutureBuilder(
            future: _loadPublicProperties,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Enquanto os dados estão carregando, exibe um spinner
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.error != null) {
                debugPrint('ERRO AO CARREGAR: $snapshot.error');
                return const Center(child: Text('Ocorreu um erro!'));
              } else {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const WelcomeArea(),
                      const FilterBox(),
                      Padding(
                        padding: const EdgeInsets.all(
                          AppConstants.defaultPadding,
                        ),
                        child: LatestAnnouncements(
                          data: properties.propertiesPublic,
                        ),
                      ),
                      const SizedBox(height: 0),
                      ForSale(
                        data: properties.propertiesPublic,
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
