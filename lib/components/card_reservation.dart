import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/dto/Scheduling.dart';
import 'package:reis_imovel_app/models/Auth.dart';
import 'package:reis_imovel_app/models/SchedulingList.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class CardReservation extends StatefulWidget {
  final Scheduling data;

  const CardReservation({required this.data, super.key});

  @override
  State<CardReservation> createState() => _CardReservationState();
}

class _CardReservationState extends State<CardReservation> {
  bool _expanded = false;

  bool _isLoading = false;

  Future<void> _deleteProperty(
      BuildContext context, String pkScheduling) async {
    setState(() => _isLoading = true);

    try {
      await Provider.of<SchedulingList>(
        context,
        listen: false,
      ).deleteScheduling(pkScheduling);

      // Navigator.of(context).pushNamed(AppRoutes.Home);

      Fluttertoast.showToast(
        msg: "Agenda cancelada com sucesso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[700],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Não foi cancelar o agendamento.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
      setState(() => _expanded = false);
    }
  }

  Widget _reservationItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          label,
          fontWeight: FontWeight.w500,
        ),
        AppText(
          value,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Auth _auth = Provider.of(context);

    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      surfaceTintColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.grey[200],
      borderOnForeground: true,
      child: Column(
        children: [
          ListTile(
            title: AppText(
              widget.data.property.title,
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: const Color(0xff687553),
            ),
            subtitle: AppText(
              "${widget.data.property.province}, ${widget.data.property.county}",
              color: Colors.grey[600],
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.expand_more,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: 580,
              child: ListView(
                children: [
                  _reservationItem(
                    'Finalidade',
                    AppUtils.getPropertyTypeTag(
                        widget.data.property.fkPropertyType),
                  ),
                  const SizedBox(height: 16),
                  _reservationItem(
                    'Valor',
                    formatPrice(widget.data.property.price),
                  ),
                  const SizedBox(height: 16),
                  _reservationItem(
                    'Área Total',
                    widget.data.property.totalArea.toString(),
                  ),
                  const SizedBox(height: 16),
                  _reservationItem(
                    'Suítes',
                    widget.data.property.suits.toString(),
                  ),
                  const SizedBox(height: 16),
                  _reservationItem(
                    'Quartos',
                    widget.data.property.room.toString(),
                  ),
                  const SizedBox(height: 16),
                  _reservationItem(
                    'Banheiros',
                    widget.data.property.bathroom.toString(),
                  ),
                  const SizedBox(height: 16),
                  _reservationItem(
                    'Vagas',
                    widget.data.property.vacancy.toString(),
                  ),
                  const SizedBox(height: 16),
                  _reservationItem(
                    'Modalidade de pagamento',
                    widget.data.property.paymentModality,
                  ),
                  const SizedBox(height: 16),
                  _reservationItem(
                    'Dia da semana',
                    AppUtils.showWeekDay(
                        widget.data.propertySchedule.dayOfWeek),
                  ),
                  const SizedBox(height: 16),
                  //'07/02/2024'
                  _reservationItem(
                    'Data da reserva',
                    AppUtils.formatDateDayMounthAndYear(widget.data.createdAt),
                  ),
                  const SizedBox(height: 16),
                  _reservationItem(
                    'Hora de início da visita',
                    widget.data.propertySchedule.startTime,
                  ),
                  const SizedBox(height: 16),
                  _reservationItem(
                    'Hora de termino da visita',
                    widget.data.propertySchedule.endTime,
                  ),
                  const SizedBox(height: 16),
                  _reservationItem('Dono do aluguel',
                      widget.data.property.companyEntity.user.fullName),
                  const SizedBox(height: 16),
                  _reservationItem('Contacto',
                      widget.data.property.companyEntity.user.phone),
                  const SizedBox(height: 16),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_auth.roles?.contains("ROLE_USER") == true)
                    Button(
                      title: 'Cancelar Reserva',
                      onPressed: () {
                        _deleteProperty(context, widget.data.pkScheduling);
                      },
                      variant: ButtonVariant.outlineAlert,
                    )
                ],
              ),
            )
        ],
      ),
    );
  }
}
