import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/card_reservation.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/Scheduling.dart';
import 'package:reis_imovel_app/models/SchedulingList.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  Future? loadSchedulingsByUser;

  @override
  void initState() {
    super.initState();
    loadSchedulingsByUser = Provider.of<SchedulingList>(
      context,
      listen: false,
    ).loadSchedulingsByUser();
  }

  Future<void> _refreshProperties(BuildContext context) async {
    await Provider.of<SchedulingList>(
      context,
      listen: false,
    ).loadSchedulingsByUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final schedulingList = Provider.of<SchedulingList>(context);
    final schedulings = schedulingList.schedulingsByUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: RefreshIndicator(
        onRefresh: () => _refreshProperties(context),
        backgroundColor: whiteColor,
        color: primaryColor,
        child: SafeArea(
          child: FutureBuilder(
            future: loadSchedulingsByUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Ocorreu um erro!'));
              } else {
                if (schedulings.isEmpty) {
                  // Mensagem de lista vazia
                  return const Center(
                    child: CustomText(
                      'Sem Agendamentos',
                      color: secondaryText,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                } else {
                  // Exibição da lista de reservas
                  return Padding(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: ListView.builder(
                      itemCount: schedulings.length,
                      itemBuilder: (ctx, index) => CardReservation(
                        data: schedulings[index],
                        onRefresh: _refreshProperties,
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
