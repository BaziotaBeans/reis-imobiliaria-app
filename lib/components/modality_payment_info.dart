import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/app_text.dart';

class ModalityPaymentInfo extends StatelessWidget {
  const ModalityPaymentInfo({super.key});

  Widget _modalBottomSheetIndicator() {
    return Center(
      child: Container(
        width: 100,
        height: 6,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(24),
      width: width,
      child: Column(
        children: [
          _modalBottomSheetIndicator(),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    'Modalidades de Pagamento',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 16),
                  AppText(
                    'A modalidade de pagamento refere-se à forma como você, como cliente, pode pagar o aluguel de um imóvel. Existem quatro opções principais: mensal, trimestral, semestral e anual.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    textAlign: TextAlign.left,
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        '1.',
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppText(
                          'Mensal: Você paga o valor do aluguel a cada mês.',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        '2.',
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppText(
                          'Trimestral: O valor do aluguel é pago a cada três meses.',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        '3.',
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppText(
                          'Semestral: O pagamento é feito a cada seis meses.',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        '4.',
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppText(
                          'Anual: Você paga o valor do aluguel uma vez por ano.',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppText(
                    'Exemplo de Cálculo:',
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  const SizedBox(height: 4),
                  AppText(
                    'Se o valor mensal do aluguel for de 50.000,00 kz, podemos calcular o equivalente para outras modalidades:',
                    fontSize: 14,
                    color: Colors.grey[700],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        '·',
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: AppText(
                          'Trimestral: 50.000,00 kz x 3 = 150.000,00 kz',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        '·',
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: AppText(
                          'Semestral: 50.000,00 kz x 6 = 300.000,00 kz',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        '·',
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: AppText(
                          'Anual: 50.000,00 kz x 12 = 600.000,00 kz',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  AppText(
                    'Escolha a modalidade que melhor se adapte às suas necessidades e orçamento.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    fontSize: 14,
                    color: Colors.grey[900],
                    height: 1.5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
