import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/card_reservation.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/Scheduling.dart';
import 'package:reis_imovel_app/models/SchedulingList.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class SchedulingScreen extends StatefulWidget {
  const SchedulingScreen({super.key});

  @override
  State<SchedulingScreen> createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends State<SchedulingScreen> {
  Future? _loadSchedulingsCompany;

  @override
  void initState() {
    super.initState();
    _loadSchedulingsCompany = Provider.of<SchedulingList>(
      context,
      listen: false,
    ).loadSchedulingByCompany();
  }

  Future<void> _refreshProperties(BuildContext context) async {
    await Provider.of<SchedulingList>(
      context,
      listen: false,
    ).loadSchedulingByCompany();

    setState(() {});
  }

  Widget showEmptyMessage() {
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height,
      child: const Center(
        child: CustomText(
          'Sem Agendamentos',
          color: secondaryText,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SchedulingList scheduling = Provider.of(context);

    List<Scheduling> schedulings = scheduling.schedulingsByCompany;

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: RefreshIndicator(
        onRefresh: () => _refreshProperties(context),
        backgroundColor: whiteColor,
        color: primaryColor,
        child: SafeArea(
          child: FutureBuilder(
            future: _loadSchedulingsCompany,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.error != null) {
                return const Center(
                  child: CustomText("Ocorreu um erro!"),
                );
              } else {
                if (schedulings.isEmpty) {
                  return const Center(
                    child: CustomText(
                      'Sem Agendamentos',
                      color: secondaryText,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(AppConstants.defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height,
                            child: ListView.builder(
                              itemCount: schedulings.length,
                              itemBuilder: (ctx, index) => CardReservation(
                                data: schedulings[index],
                                onRefresh: _refreshProperties,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
