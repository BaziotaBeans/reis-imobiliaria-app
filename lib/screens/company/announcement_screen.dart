import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/card_immbobile_horizontal.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/models/PropertyList.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  Future? _loadPropertiesCompany;

  @override
  void initState() {
    super.initState();
    _loadPropertiesCompany = Provider.of<PropertyList>(
      context,
      listen: false,
    ).loadCompanyProperties();
  }

  Future<void> _refreshProperties(BuildContext context) async {
    await Provider.of<PropertyList>(
      context,
      listen: false,
    ).loadCompanyProperties();

    setState(() {});
  }

  Widget _addAnnouncementBox(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed(AppRoutes.SELECT_ANNOUNCEMENT_TYPE);
        Navigator.of(context).pushNamed(AppRoutes.SELECT_PROPERTY_TYPE_SCREEN);
      },
      child: SizedBox(
        width: double.infinity,
        child: DottedBorder(
          color: primaryColor,
          strokeWidth: 2,
          dashPattern: const [5, 10],
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: FaIcon(
                    FontAwesomeIcons.circlePlus,
                    size: 42,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 10),
                CustomText(
                  'Clique aqui para anunciar o seu imóvel',
                  textAlign: TextAlign.center,
                  color: primaryColor,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomText(
          'Meus Anúncios',
          color: secondaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          // height: 0.06,
        ),
        CustomText(
          "Total: ${propertyLength.toString()}",
          fontSize: 14,
          color: secondaryText,
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
        backgroundColor: whiteColor,
        color: primaryColor,
        child: SafeArea(
          child: FutureBuilder(
            future: _loadPropertiesCompany,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.error != null) {
                debugPrint('#################');
                debugPrint('${snapshot.error}');
                debugPrint('#################');
                return const Center(
                  child: CustomText("Ocorreu um erro!"),
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 24),
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
                        Wrap(
                          runSpacing: 20,
                          children: <Widget>[
                            if (properties.propertiesCompany.isEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 80, horizontal: 24),
                                child: Center(
                                  child: CustomText(
                                    'Não possui nenhum anúncio',
                                  ),
                                ),
                              )
                            else
                              for (PropertyResult item
                                  in properties.propertiesCompany)
                                CardImmobileHorizontal(
                                  data: item,
                                ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
                // if (properties.propertiesCompany.isEmpty) {
                //   return const Center(
                //     child: CustomText(
                //       'Sem Imvovel',
                //       color: secondaryText,
                //       fontSize: 24,
                //       fontWeight: FontWeight.w600,
                //     ),
                //   );
                // } else {

                // }
              }
            },
          ),
        ),
      ),
    );
  }
}
