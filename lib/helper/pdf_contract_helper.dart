import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:reis_imovel_app/dto/Contract.dart';
import 'package:reis_imovel_app/helper/pdf_helper.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';
import 'package:reis_imovel_app/utils/formatPrice.dart';

class PdfContractHelper {
  static Future<File> generate(Contract data) async {
    final pdf = pw.Document();

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

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text(
            "Última actualização: ${AppUtils.formatDateDayMounthAndYear(data.startDate)}",
            style: const pw.TextStyle(color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            'CONTRATO DE LOCAÇÃO RESIDENCIAL',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            'Partes Contratantes:',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "LOCADOR: ${data.user.fullName}, natural de ${data.user.nationality}, ${data.user.maritalStatus}, portador do NIF nº ${data.user.nif}, residente e domiciliado na ${data.user.address}, doravante denominado simplesmente \"LOCADOR\".",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              fontSize: 14,
              height: 1.6,
            ),
            softWrap: true,
            maxLines: 8,
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "LOCATÁRIO: ${data.property.companyEntity.user.fullName}, ${data.property.companyEntity.user.nationality}, ${data.property.companyEntity.user.maritalStatus}, portador do NIF nº ${data.property.companyEntity.nif}, residente e domiciliado na ${data.property.companyEntity.user.address}, doravante denominado simplesmente \"LOCATÁRIO\".",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              fontSize: 14,
              height: 1.6,
            ),
            softWrap: true,
            maxLines: 8,
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "Objeto do Contrato:",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "O LOCADOR, por meio deste instrumento, cede ao LOCATÁRIO, para fins de locação residencial, o imóvel situado na província de ${data.property.province}, ${data.property.county} ${data.property.address}, contendo uma casa de tipologia ${data.property.room}, com ${data.property.room} quartos, ${data.property.bathroom} banheiro, ${data.property.suits} suíte, cozinha e varanda, doravante denominado simplesmente \"IMÓVEL\".",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              fontSize: 14,
              height: 1.6,
            ),
            softWrap: true,
            maxLines: 8,
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "Prazo de Locação:",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "O prazo de locação do IMÓVEL terá início em ${AppUtils.formatDateDayMounthAndYear(data.startDate)} e término em ${AppUtils.formatDateDayMounthAndYear(data.endDate ?? DateTime.now().toString())}.",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              fontSize: 14,
              height: 1.6,
            ),
            softWrap: true,
            maxLines: 8,
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "Modalidade de Pagamento:",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "O valor do aluguel mensal do IMÓVEL é estabelecido em ${formatPrice(data.property.price)}, a ser pago pelo LOCATÁRIO ${AppUtils.getPaymentModalityTextForContract(data.property.paymentModality)}, até o dia 10 de cada ${AppUtils.getPaymentModalityForContract(data.property.paymentModality)}, através de Pagamento por referência/transferência bancária.",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              fontSize: 14,
              height: 1.6,
            ),
            softWrap: true,
            maxLines: 8,
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "Obrigações do LOCATÁRIO:",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Column(
            children: str1.map((item) {
              return pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    "* ",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 16,
                    ),
                  ), //bullet text
                  pw.SizedBox(
                    height: 10,
                  ), //space between bullet and text
                  pw.Expanded(
                    child: pw.Text(
                      item,
                      style: const pw.TextStyle(
                        fontSize: 14,
                        height: 1.6,
                      ),
                      softWrap: true,
                      maxLines: 8,
                    ),
                  )
                ],
              );
            }).toList(),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "Obrigações do LOCADOR:",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Column(
            children: str2.map((item) {
              return pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      "* ",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                      ),
                    ), //bullet text
                    pw.SizedBox(
                      height: 10,
                    ), //space between bullet and text
                    pw.Expanded(
                      child: pw.Text(
                        item,
                        style: const pw.TextStyle(
                          fontSize: 14,
                          height: 1.6,
                        ),
                        softWrap: true,
                        maxLines: 8,
                      ),
                    ),
                  ]);
            }).toList(),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "Disposições Gerais:",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 16,
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Column(
            children: str3.map((item) {
              return pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      "* ",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                      ),
                    ), //bullet text
                    pw.SizedBox(
                      height: 10,
                    ), //space between bullet and text
                    pw.Expanded(
                      child: pw.Text(
                        item,
                        style: const pw.TextStyle(
                          fontSize: 14,
                          height: 1.6,
                        ),
                        softWrap: true,
                        maxLines: 8,
                      ),
                    ),
                  ]);
            }).toList(),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "Por estarem assim justos e contratados, firmam o presente instrumento em duas vias de igual teor, na presença de duas testemunhas.",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 14,
              height: 1.6,
            ),
            softWrap: true,
            maxLines: 8,
          ),
        ],
        // footer: (Context) => ,
      ),
    );

    return PdfHelper.saveDocument(name: 'contracto.pdf', pdf: pdf);
  }
}
