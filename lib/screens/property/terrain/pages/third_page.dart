import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/schedule_status.dart';
import 'package:reis_imovel_app/models/Schedule.dart';
import 'package:reis_imovel_app/screens/property/components/subtitle_page.dart';
import 'package:reis_imovel_app/screens/property/components/title_page.dart';
import 'package:reis_imovel_app/utils/constants.dart';

//void _updateSchedule(List<Schedule> schedules)

class ThirdPage extends StatefulWidget {
  final void Function(List<Schedule> schedules) onUpdateSchedule;

  final List<Schedule> selectedSchedules;

  final GlobalKey<FormState> formKey;

  const ThirdPage({
    super.key,
    required this.formKey,
    required this.onUpdateSchedule,
    required this.selectedSchedules,
  });

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitlePage(title: 'Agendamento'),
            const SubtitlePage(
              description:
                  'Crie o agendamento para as visitas semanais do imóvel.',
            ),
            const SizedBox(height: 24),
            const Divider(color: blackColor5, height: 1),
            const SizedBox(height: 24),
            ScheduleStatus(
              selectedSchedules: widget.selectedSchedules,
              addSchedule: widget.onUpdateSchedule,
            )
          ],
        ),
      ),
    );
  }
}
