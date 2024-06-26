import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reis_imovel_app/components/app_dropdown_form_field.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/data/day_of_week_data.dart';
import 'package:reis_imovel_app/enums.dart';
import 'package:reis_imovel_app/models/Schedule.dart';
import 'package:reis_imovel_app/utils/app_colors.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';

class ScheduleStatus extends StatefulWidget {
  final List<Schedule> selectedSchedules;
  final void Function(List<Schedule> schedules) addSchedule;

  const ScheduleStatus({
    required this.selectedSchedules,
    required this.addSchedule,
    super.key,
  });

  @override
  State<ScheduleStatus> createState() => _ScheduleStatusState();
}

class _ScheduleStatusState extends State<ScheduleStatus> {
  // PropertyStatus? _selectedStatus = PropertyStatus.PUBLISHED;

  List<Schedule> _schedules = [];

  final _dayOfWeekController = TextEditingController();

  // final _selectedStatusController = TextEditingController();

  TimeOfDay? _selectedStartTime;

  TimeOfDay? _selectedEndTime;

  Future<void> _selectTime(BuildContext context,
      {required bool isStartTime}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _selectedStartTime = picked;
        } else {
          _selectedEndTime = picked;
        }
      });
    }
  }

  void _removeScheduleItem(int index) {
    setState(() {
      _schedules = List.from(_schedules)..removeAt(index);
    });

    widget.addSchedule(_schedules);
  }

  void _addSchedule() {
    if (_selectedStartTime != null && _selectedEndTime != null) {
      setState(() {
        _schedules.add(Schedule(
          dayOfWeek: AppUtils.getWeekDay( _dayOfWeekController.text),
          startTime: AppUtils.formatTimeInPickedTime(_selectedStartTime!),
          endTime: AppUtils.formatTimeInPickedTime(_selectedEndTime!),
        ));

        _dayOfWeekController.clear();
        _selectedStartTime = null;
        _selectedEndTime = null;
      });

      _schedules.forEach((element) {
        print(element.dayOfWeek);
      });

      widget.addSchedule(_schedules);
    }
  }

  Widget _tagWeekDaySchedule(String label, int index) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      // width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Colors.grey[500],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            offset: const Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
        children: [
          AppText(
            AppUtils.showWeekDay(label),
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(width: 10),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            radius: 10,
            onTap: () {
              _removeScheduleItem(index);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[700],
              ),
              width: 20,
              height: 20,
              alignment: Alignment.center,
              child: const FaIcon(
                FontAwesomeIcons.xmark,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listOfSelectedSchedules() {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        // color: Colors.green[400],
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Dias de semanas selecionadas',
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: width,
            height: 35,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return _tagWeekDaySchedule(_schedules[index].dayOfWeek, index);
              },
              itemCount: _schedules.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 5);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _timePickerUI(
      String labelText, bool isStartTime, TimeOfDay? _selectedTime) {
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        _selectTime(context, isStartTime: isStartTime);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            labelText,
            color: Colors.grey[600],
            fontSize: 14,
          ),
          Container(
            width: width,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              color: AppColors.inputFillColor,
            ),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.clock,
                  size: 18,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 10),
                if (_selectedTime == null)
                  const Expanded(
                    child: AppText(
                      'Por favor selecione a data',
                      color: Color(0x993C3C43),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                if (_selectedTime != null)
                  // AppText(_selectedTime.format(context), fontSize: 16)
                  AppText(
                    AppUtils.formatTimeInPickedTime(_selectedTime),
                    fontSize: 16,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppDropdownFormField(
          controller: _dayOfWeekController,
          hintText: 'Selecione os dias da semana',
          labelText: 'Dias da semana',
          list: dayOfWeekData,
          widthValueOfPadding: 41,
          onSelected: (value) {
            print(PropertyStatus.values);
            // setState(() => updateProvinceValueState = value ?? '');
            // _formData['province'] = value ?? '';
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child:
                    _timePickerUI('Hora de início', true, _selectedStartTime)),
            const SizedBox(width: 10),
            Expanded(
                child:
                    _timePickerUI('Hora de termino', false, _selectedEndTime)),
          ],
        ),
        const SizedBox(height: 14),
        TextButton(
          onPressed: _addSchedule,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.plus,
                size: 14,
              ),
              SizedBox(width: 6),
              AppText('Adicionar Novo Agendamento', color: Colors.white)
            ],
          ),
        ),
        const SizedBox(height: 14),
        _listOfSelectedSchedules(),
      ],
    );
  }
}

//AppColors.primaryColor
