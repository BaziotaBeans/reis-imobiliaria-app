import 'package:flutter/material.dart';
import 'package:reis_imovel_app/components/new/custom_button.dart';
import 'package:reis_imovel_app/components/new/custom_text.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/screens/contract/components/awaiting_signature_contract_box.dart';
import 'package:reis_imovel_app/screens/contract/components/signature_contract_box.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class ContractRentedContent extends StatelessWidget {
  final Contract data;
  final bool isClient;
  final Future<void> Function(Contract) onDownloadPdf;
  final Future<void> Function(BuildContext) onRefresh;

  const ContractRentedContent({
    super.key,
    required this.data,
    required this.isClient,
    required this.onDownloadPdf,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    List<String> str1 = [
      "O LOCATÁRIO se compromete a utilizar o IMÓVEL para fins exclusivamente residenciais, não podendo sublocar, ceder ou emprestar, total ou parcialmente, o imóvel a terceiros, sem prévia autorização por escrito do LOCADOR.",
      "O LOCATÁRIO se responsabiliza pela conservação do IMÓVEL, devendo realizar os reparos necessários para manter o imóvel em condições adequadas de habitabilidade, salvo os casos de reparos estruturais que são de responsabilidade do LOCADOR.",
      "O LOCATÁRIO se compromete a pagar pontualmente o valor do aluguel nas datas estipuladas neste contrato, sob pena de incidência de multa moratória de [Percentual da Multa Moratória] (%), acrescida de juros de mora de [Percentual dos Juros de Mora] (%)."
    ];

    List<String> str2 = [
      "O LOCADOR se compromete a entregar o IMÓVEL em perfeitas condições de habitabilidade, realizando todos os reparos necessários antes da entrada do LOCATÁRIO.",
      "O LOCADOR se compromete a fornecer ao LOCATÁRIO recibo de pagamento do aluguel, conforme solicitado."
    ];

    List<String> str3 = [
      "O presente contrato é regido pelas leis vigentes da República de Angola.",
      "Qualquer alteração ou aditamento a este contrato só terá validade se feito por escrito e assinado por ambas as partes contratantes.",
      "Para dirimir quaisquer dúvidas ou controvérsias oriundas deste contrato, as partes elegem o Foro da Comarca do ${data.property.county}, com renúncia expressa de qualquer outro, por mais privilegiado que seja."
    ];

    bool isNotHaveSignatureOwner =
        !isClient && data.signaturePropertyOwner == null;

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            "Última actualização: ${AppUtils.formatDateDayMounthAndYear(data.startDate)}",
            color: const Color(0xaf3c3c43),
          ),
          const SizedBox(height: 16),
          const CustomText(
            'CONTRATO DE LOCAÇÃO RESIDENCIAL',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(height: 16),
          const CustomText(
            'Partes Contratantes:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          CustomText(
            "LOCATÁRIO: ${data.user.fullName}, natural de ${data.user.nationality}, ${data.user.maritalStatus}, portador do NIF nº ${data.user.nif}, residente e domiciliado na ${data.user.address}, doravante denominado simplesmente \"LOCATÁRIO\".",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          CustomText(
            "LOCADOR: ${data.property.companyEntity.user.fullName}, ${data.property.companyEntity.user.nationality}, ${data.property.companyEntity.user.maritalStatus}, portador do NIF nº ${data.property.companyEntity.nif}, residente e domiciliado na ${data.property.companyEntity.user.address}, doravante denominado simplesmente \"LOCADOR\".",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            'Objeto do Contrato:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          CustomText(
            "O LOCADOR, por meio deste instrumento, cede ao LOCATÁRIO, para fins de locação residencial, o imóvel situado na província de ${data.property.province}, ${data.property.county} ${data.property.address}, contendo uma casa de tipologia ${data.property.room}, com ${data.property.room} quartos, ${data.property.bathroom} banheiro, ${data.property.suits} suíte, cozinha e varanda, doravante denominado simplesmente \"IMÓVEL\".",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            'Prazo de Locação:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          CustomText(
            "O prazo de locação do IMÓVEL terá início em ${AppUtils.formatDateDayMounthAndYear(data.startDate)} e término em ${AppUtils.formatDateDayMounthAndYear(data.endDate ?? DateTime.now().toString())}.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            'Modalidade de Pagamento:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          CustomText(
            "O valor do aluguel mensal do IMÓVEL é estabelecido em ${formatPrice(data.property.price)}, a ser pago pelo LOCATÁRIO ${AppUtils.getPaymentModalityTextForContract(data.property.paymentModality)}, até o dia 10 de cada ${AppUtils.getPaymentModalityForContract(data.property.paymentModality)}, através de Pagamento por referência/transferência bancária.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const CustomText(
            'Obrigações do LOCATÁRIO:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          Column(
            children: str1.map((item) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomText(
                      "\u2022",
                      fontSize: 24,
                    ), //bullet text
                    const SizedBox(
                      width: 10,
                    ), //space between bullet and text
                    Expanded(
                      child: CustomText(
                        item,
                        fontSize: 14,
                        softWrap: true,
                        maxLines: 8,
                        height: 1.5,
                      ), //text
                    )
                  ]);
            }).toList(),
          ),
          const SizedBox(height: 16),
          const CustomText(
            'Obrigações do LOCADOR:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          Column(
            children: str2.map((item) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomText(
                      "\u2022",
                      fontSize: 24,
                    ), //bullet text
                    const SizedBox(
                      width: 10,
                    ), //space between bullet and text
                    Expanded(
                      child: CustomText(
                        item,
                        fontSize: 14,
                        softWrap: true,
                        maxLines: 8,
                        height: 1.5,
                      ), //text
                    )
                  ]);
            }).toList(),
          ),
          const SizedBox(height: 16),
          const CustomText(
            'Disposições Gerais:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          Column(
            children: str3.map((item) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomText(
                      "\u2022",
                      fontSize: 24,
                    ), //bullet text
                    const SizedBox(
                      width: 10,
                    ), //space between bullet and text
                    Expanded(
                      child: CustomText(
                        item,
                        fontSize: 14,
                        softWrap: true,
                        maxLines: 8,
                        height: 1.5,
                      ), //text
                    )
                  ]);
            }).toList(),
          ),
          const SizedBox(height: 16),
          const CustomText(
            'Por estarem assim justos e contratados, firmam o presente instrumento em duas vias de igual teor, na presença de duas testemunhas.',
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          SignatureContractBox(
            data: data,
          ),
          // if (isClient) const SizedBox(height: 24),
          // if (isClient) const RenewContractBox(),
          if (isNotHaveSignatureOwner)
            AwaitingSignatureContractBox(
              data: data,
              onRefresh: onRefresh,
            ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Baixar PDF',
            onPressed: () => onDownloadPdf(data),
            prefixIcon: Icons.download_sharp,
          ),
        ],
      ),
    );
  }
}
