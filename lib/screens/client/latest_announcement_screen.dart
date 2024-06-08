import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/components/home/card_result.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/models/PropertyList.dart';

class LatestAnnouncementScreen extends StatefulWidget {
  const LatestAnnouncementScreen({super.key});

  @override
  State<LatestAnnouncementScreen> createState() =>
      _LatestAnnouncementScreenState();
}

class _LatestAnnouncementScreenState extends State<LatestAnnouncementScreen> {
  @override
  Widget build(BuildContext context) {
    final PropertyList properties = Provider.of(context);

    final List<PropertyResult> propertyList = properties.propertiesPublic;

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(title: 'Últimos Anúncios'),
              SizedBox(
                height: screenHeight,
                child: ListView.separated(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: CardResult(data: propertyList[index]),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 0),
                  itemCount: propertyList.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
