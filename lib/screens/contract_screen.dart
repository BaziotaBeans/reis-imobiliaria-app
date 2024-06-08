import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reis_imovel_app/components/app_text.dart';
import 'package:reis_imovel_app/components/button.dart';
import 'package:reis_imovel_app/components/contract_content_sale.dart';
import 'package:reis_imovel_app/components/header.dart';
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/helper/pdf_contract_helper.dart';
import 'package:reis_imovel_app/helper/pdf_helper.dart';
import 'package:reis_imovel_app/models/Auh.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class ContractScreen extends StatelessWidget {
  const ContractScreen({super.key});

  Widget _content(Contract data, bool isClient) {
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
          AppText(
            "Última actualização: ${AppUtils.formatDateDayMounthAndYear(data.startDate)}",
            color: const Color(0xaf3c3c43),
          ),
          const SizedBox(height: 16),
          const AppText(
            'CONTRATO DE LOCAÇÃO RESIDENCIAL',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(height: 16),
          const AppText(
            'Partes Contratantes:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          AppText(
            "LOCADOR: ${data.user.fullName}, natural de ${data.user.nationality}, ${data.user.maritalStatus}, portador do NIF nº ${data.user.nif}, residente e domiciliado na ${data.user.address}, doravante denominado simplesmente \"LOCADOR\".",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          AppText(
            "LOCATÁRIO: ${data.property.companyEntity.user.fullName}, ${data.property.companyEntity.user.nationality}, ${data.property.companyEntity.user.maritalStatus}, portador do NIF nº ${data.property.companyEntity.nif}, residente e domiciliado na ${data.property.companyEntity.user.address}, doravante denominado simplesmente \"LOCATÁRIO\".",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const AppText(
            'Objeto do Contrato:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          AppText(
            "O LOCADOR, por meio deste instrumento, cede ao LOCATÁRIO, para fins de locação residencial, o imóvel situado na província de ${data.property.province}, ${data.property.county} ${data.property.address}, contendo uma casa de tipologia ${data.property.room}, com ${data.property.room} quartos, ${data.property.bathroom} banheiro, ${data.property.suits} suíte, cozinha e varanda, doravante denominado simplesmente \"IMÓVEL\".",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const AppText(
            'Prazo de Locação:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          AppText(
            "O prazo de locação do IMÓVEL terá início em ${AppUtils.formatDateDayMounthAndYear(data.startDate)} e término em ${AppUtils.formatDateDayMounthAndYear(data.endDate ?? DateTime.now().toString())}.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const AppText(
            'Modalidade de Pagamento:',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16),
          AppText(
            "O valor do aluguel mensal do IMÓVEL é estabelecido em ${formatPrice(data.property.price)}, a ser pago pelo LOCATÁRIO ${AppUtils.getPaymentModalityTextForContract(data.property.paymentModality)}, até o dia 10 de cada ${AppUtils.getPaymentModalityForContract(data.property.paymentModality)}, através de Pagamento por referência/transferência bancária.",
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          const SizedBox(height: 16),
          const AppText(
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
                    const AppText(
                      "\u2022",
                      fontSize: 24,
                    ), //bullet text
                    const SizedBox(
                      width: 10,
                    ), //space between bullet and text
                    Expanded(
                      child: AppText(
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
          const AppText(
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
                    const AppText(
                      "\u2022",
                      fontSize: 24,
                    ), //bullet text
                    const SizedBox(
                      width: 10,
                    ), //space between bullet and text
                    Expanded(
                      child: AppText(
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
          const AppText(
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
                    const AppText(
                      "\u2022",
                      fontSize: 24,
                    ), //bullet text
                    const SizedBox(
                      width: 10,
                    ), //space between bullet and text
                    Expanded(
                      child: AppText(
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
          const AppText(
            'Por estarem assim justos e contratados, firmam o presente instrumento em duas vias de igual teor, na presença de duas testemunhas.',
            fontSize: 14,
            softWrap: true,
            maxLines: 8,
            height: 1.6,
          ),
          if (isClient) const SizedBox(height: 24),
          if (isClient)
            Button(
              title: 'Actualizar',
              onPressed: () {},
              variant: ButtonVariant.primary,
            ),
          if (isClient) const SizedBox(height: 24),
          Button(
            title: 'Baixar PDF',
            onPressed: () async {
              final pdfFile = await PdfContractHelper.generate(data);

              print("yes");

              PdfHelper.openFile(pdfFile);
            },
            variant: ButtonVariant.secondary,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Contract data = ModalRoute.of(context)?.settings.arguments as Contract;

    Auth auth = Provider.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                title: 'Contrato de Aluguel',
                onPressed: () {},
              ),
              if (data.property.fkPropertyType == AppConstants.propertyTypeRent)
                _content(data, auth.roles?.contains("ROLE_USER") == true),
              if (data.property.fkPropertyType ==
                      AppConstants.propertyTypeGround ||
                  data.property.fkPropertyType == AppConstants.propertyTypeSale)
                ContractContentSale(data: data)
            ],
          ),
        ),
      ),
    );
  }
}
