import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/dto/PropertyScheduleResult.dart';
import 'package:reis_imovel_app/models/PropertyScheduleList.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';

class SchedulePicker extends StatefulWidget {
  final String pkProperty;

  const SchedulePicker({Key? key, required this.pkProperty}) : super(key: key);

  @override
  State<SchedulePicker> createState() => _SchedulePickerState();
}

class _SchedulePickerState extends State<SchedulePicker> {
  String? selectedScheduleId;

  bool _isLoading = false;

  void _selectSchedule(String pkPropertySchedule) {
    setState(() {
      selectedScheduleId = pkPropertySchedule;
    });

    print(selectedScheduleId);
  }

  Future<void> _submit() async {
    final msg = ScaffoldMessenger.of(context);

    if (selectedScheduleId == null) return;

    setState(() => _isLoading = true);

    try {
      await Provider.of<PropertyScheduleList>(context, listen: false)
          .createScheduling(selectedScheduleId ?? '', widget.pkProperty);

      msg.showSnackBar(
        const SnackBar(
          content: Text('Visita agendado com sucesso'),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      print(e.toString());

      msg.showSnackBar(
        const SnackBar(
          content: Text('Ocorreu um erro ao efectuar o agendamento'),
          duration: Duration(seconds: 30),
        ),
      );
      Navigator.pop(context);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final PropertyScheduleList propertySchedule = Provider.of(context);

    List<PropertyScheduleResult> schedules =
        propertySchedule.propertiesAvailableSchedules;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                'Agendar Visita',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF687553),
              ),
              const SizedBox(height: 6),
              AppText(
                'Selecione o dia da semana e hora que deseja para o agendamento.',
                fontSize: 14,
                color: Colors.grey[600],
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
              )
            ],
          ),
        ),
        if (schedules.isEmpty)
          const Center(child: AppText('Sem agendamentos para o dia'))
        else
          Container(
            height: 150, // Ajuste conforme necessário
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                var schedule = schedules[index];
                return ListTile(
                  title: Text(
                      '${AppUtils.showWeekDay(schedule.dayOfWeek)}: ${schedule.startTime} - ${schedule.endTime}'),
                  leading: Radio<String>(
                    value: schedule.pkPropertySchedule,
                    groupValue: selectedScheduleId,
                    activeColor: const Color(0xff687553),
                    onChanged: (value) {
                      if (value != null) {
                        _selectSchedule(value);
                      }
                    },
                  ),
                  contentPadding: const EdgeInsets.only(
                      bottom: 0, left: 0, right: 14, top: 0),
                  titleTextStyle: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontFamily: 'Avenir',
                  ),
                  trailing: FaIcon(FontAwesomeIcons.calendarWeek,
                      size: 16, color: Colors.grey[600]),
                  onTap: () => _selectSchedule(schedule.pkPropertySchedule),
                );
              },
            ),
          ),
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Center(child: CircularProgressIndicator(color: Colors.blue)),
          )
        else
          Padding(
            padding: const EdgeInsets.all(24),
            child: Button(
              onPressed: selectedScheduleId != null ? _submit : null,
              withAddIcon: true,
              variant: ButtonVariant.primary,
              title: 'Confirmar Agendamento',
            ),
          )
      ],
    );
  }
}
