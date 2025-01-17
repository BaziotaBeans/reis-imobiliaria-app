import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:reis_imovel_app/dto/Contract.dart';

class ContractPdfGenerator {
  static Future<void> generateContractPdf(Contract data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'CONTRATO DE LOCACAO RESIDENCIAL',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text('Partes Contratantes:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(
              'LOCATARIO: ${_sanitizeText(data.user.fullName)}, '
              'NIF: ${data.user.nif}, '
              'Endereco: ${_sanitizeText(data.user.address)}',
            ),
            pw.Text(
              'LOCADOR: ${_sanitizeText(data.property.companyEntity.user.fullName)}, '
              'NIF: ${data.property.companyEntity.nif}, '
              'Endereco: ${_sanitizeText(data.property.companyEntity.user.address)}',
            ),
            pw.SizedBox(height: 10),
            pw.Text('Detalhes do Contrato:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(
              'Imovel: ${_sanitizeText(data.property.address)}, '
              'Provincia: ${_sanitizeText(data.property.province)}, '
              'Tipologia: ${data.property.room} quartos',
            ),
            pw.SizedBox(height: 10),
            pw.Text('Periodo de Locacao:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(
              'Inicio: ${_formatDate(data.startDate)}, '
              'Fim: ${_formatDate(data.endDate ?? DateTime.now().toString())}',
            ),
            pw.SizedBox(height: 10),
            pw.Text('Valor do Aluguel:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(
              'Valor Mensal: ${_formatCurrency(data.property.price)}',
            ),
            pw.SizedBox(height: 20),
            pw.Text('Assinaturas',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(children: [
                  pw.Container(
                    width: 200,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: 1)),
                    ),
                    child: pw.Text(
                        data.signaturePropertyCustomer?.isNotEmpty == true
                            ? _sanitizeText(data.user.fullName)
                            : '---',
                        textAlign: pw.TextAlign.center),
                  ),
                  pw.Text('Locatario')
                ]),
                pw.Column(children: [
                  pw.Container(
                    width: 200,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: 1)),
                    ),
                    child: pw.Text(
                        data.signaturePropertyOwner?.isNotEmpty == true
                            ? _sanitizeText(
                                data.property.companyEntity.user.fullName)
                            : '---',
                        textAlign: pw.TextAlign.center),
                  ),
                  pw.Text('Locador')
                ]),
              ],
            ),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/contrato_locacao_${data.pkContract}.pdf');
    await file.writeAsBytes(await pdf.save());

    await OpenFile.open(file.path);
  }

  static String _sanitizeText(String input) {
    // Remove special characters and normalize text
    return input.replaceAll(RegExp(r'[^\w\s]'), '');
  }

  static String _formatDate(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static String _formatCurrency(double value) {
    return 'AOA ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
