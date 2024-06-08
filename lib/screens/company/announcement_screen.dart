import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/card_immbobile_horizontal.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/models/PropertyList.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PropertyList>(
      context,
      listen: false,
    ).loadCompanyProperties();
  }

  Future<void> _refreshProperties(BuildContext context) {
    return Provider.of<PropertyList>(
      context,
      listen: false,
    ).loadCompanyProperties();
  }

  Widget _addAnnouncementBox(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.SELECT_ANNOUNCEMENT_TYPE);
      },
      child: Container(
        width: double.infinity,
        child: DottedBorder(
          color: Colors.blue,
          strokeWidth: 2,
          dashPattern: const [5, 10],
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.blue.shade50.withOpacity(.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: FaIcon(FontAwesomeIcons.circlePlus,
                      size: 42, color: Colors.blue),
                ),
                SizedBox(height: 10),
                AppText(
                  'Clique aqui para anunciar o seu imóvel',
                  textAlign: TextAlign.center,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.5,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headingSection(int propertyLength) {
    print(propertyLength);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AppText(
          'Meus Anúncios',
          textAlign: TextAlign.center,
          color: Color(0xFF1E2640),
          fontSize: 20,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          // height: 0.06,
        ),
        AppText(
          "Total: ${propertyLength.toString()}",
          fontSize: 14,
          color: const Color(0xFF6A7380),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final PropertyList properties = Provider.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: RefreshIndicator(
        onRefresh: () => _refreshProperties(context),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                children: [
                  _addAnnouncementBox(context),
                  const SizedBox(
                    height: 24,
                  ),
                  _headingSection(properties.propertiesCompany.length),
                  const SizedBox(
                    height: 32,
                  ),
                  Wrap(runSpacing: 20, children: <Widget>[
                    if (properties.propertiesCompany.isEmpty)
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 80, horizontal: 24),
                        child: Center(
                          child: AppText(
                            'Não possui nenhum anúncio',
                          ),
                        ),
                      )
                    else
                      for (PropertyResult item in properties.propertiesCompany)
                        CardImmobileHorizontal(
                          data: item,
                        )
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
