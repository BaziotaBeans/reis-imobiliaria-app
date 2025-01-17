import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';
import 'package:reis_imovel_app/utils/constants.dart';

class SuccessNewPropertyScreen extends StatefulWidget {
  const SuccessNewPropertyScreen({super.key});

  @override
  State<SuccessNewPropertyScreen> createState() =>
      _SuccessNewPropertyScreenState();
}

class _SuccessNewPropertyScreenState extends State<SuccessNewPropertyScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 5),
    );

    // Start the confetti animation when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(child: SizedBox()),
                Center(
                  child: Image.asset(
                    "assets/images/confetti.png",
                    fit: BoxFit.cover,
                    width: 150,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  'Tudo pronto!',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                const Expanded(
                  child: CustomText(
                    'Seu imóvel foi cadastrado com sucesso. Agora está tudo pronto.',
                    softWrap: true,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                // const Expanded(child: SizedBox()),
                CustomButton(
                  text: 'Iniciar',
                  variant: ButtonVariant.tertiary,
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.ANNOUNCEMENT_SCREEN);
                  },
                ),
              ],
            ),
          ),
          // Confetti effect
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.directional,
              blastDirection: -3.14 / 2, // Down direction
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.3,
              colors: const [
                Colors.white,
                Colors.yellow,
                Colors.blue,
                Colors.green,
                Colors.red,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
