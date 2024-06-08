import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/screens/home_screen.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';

class CountdownTimerWidget extends StatefulWidget {
  final DateTime expiryDate;

  final int diffBetweenDate;

  const CountdownTimerWidget(
      {required this.expiryDate, required this.diffBetweenDate});

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late int endTime;
  final ValueNotifier<double> _progressNotifier =
      ValueNotifier(1.0); // Inicializa a 100%

  @override
  void initState() {
    super.initState();
    // Configura o endTime baseado na diffBetweenDate
    // endTime = DateTime.now().millisecondsSinceEpoch + widget.diffBetweenDate;
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  }

  void onTimerComplete(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('O temporizador terminou!')),
    );

    Navigator.of(context).pushReplacementNamed(
      AppRoutes.Home,
    );
    // Você pode colocar qualquer lógica adicional aqui, como exibir uma mensagem.
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CountdownTimer(
          // endTime: expir,
          endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 50,
          onEnd: () => onTimerComplete(context),
          widgetBuilder: (_, CurrentRemainingTime? time) {
            if (time == null) {
              return const AppText('Tempo esgotado');
            }
            // Atualiza a barra de progresso com base no tempo restante
            int totalTime = DateTime.now().millisecondsSinceEpoch +
                1000 * 60; //widget.diffBetweenDate;
            int currentTime = (time.min ?? 0) * 60000 + (time.sec ?? 0) * 1000;
            _progressNotifier.value = currentTime / totalTime;

            return AppText(
              '${time.min ?? 0}:${time.sec ?? 0}',
              fontSize: 20,
            );
          },
          endWidget: const AppText('Tempo esgotado'),
        ),
        const SizedBox(height: 10),
        // LinearProgressIndicator(
        //   value: _progressNotifier.value,
        //   semanticsLabel: 'Barra de progresso',
        //   backgroundColor: const Color(0x5e787880),
        //   color: Colors.blue,
        //   minHeight: 6,
        // ),
      ],
    );
  }
}
