import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/utils/app_routes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF9F9F9), // Corrigido para uma sintaxe de cor válida
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 120,
                  bottom: 24,
                ),
                child: AppText(
                  "Maneira fácil de encontrar seu sonho e ótima casa",
                  color: Color(0xff3D3F33),
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 0,
                  bottom: 24,
                ),
                child: AppText(
                  "Obtenha os insights mais recentes sobre sua propriedade, como o preço médio de venda de propriedades comparáveis, rastreando sua casa no painel do proprietário da propriedade.",
                  maxLines: 8,
                  softWrap: true,
                  color: Color(0xff88898F),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Expanded(
            // Utilize Expanded para ocupar o espaço restante
            child: Stack(
              children: [
                Positioned.fill(
                  // Usar Positioned.fill para cobrir o espaço disponível
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/onboarding-house-image.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  // Usar Positioned.fill aqui também
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.grey.withOpacity(0.0),
                          Color(0xff687553),
                        ],
                        stops: [0.0, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20, // Define a margem inferior
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.SIGN_IN);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.white),
                          foregroundColor:
                              const MaterialStatePropertyAll(Color(0xff687553)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const AppText(
                          "Iniciar",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
