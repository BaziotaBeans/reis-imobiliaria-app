import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:reis_imovel_app/dto/Contract.dart';

class PropertyPurchasePdfGenerator {
  static Future<void> generatePurchaseContractPdf(Contract data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'CONTRATO DE COMPRA E VENDA DE IMOVEL',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text('Partes Contratantes:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(
              'COMPRADOR: ${_sanitizeText(data.user.fullName)}, '
              'NIF: ${data.user.nif}, '
              'Endereco: ${_sanitizeText(data.user.address)}',
            ),
            pw.Text(
              'VENDEDOR: ${_sanitizeText(data.property.companyEntity.user.fullName)}, '
              'NIF: ${data.property.companyEntity.user.nif}, '
              'Endereco: ${_sanitizeText(data.property.companyEntity.user.fullName)}',
            ),
            pw.SizedBox(height: 10),
            pw.Text('Detalhes do Imovel:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(
              'Endereco: ${_sanitizeText(data.property.address)}, '
              'Provincia: ${_sanitizeText(data.property.province)}, '
              'Tipologia: ${data.property.room} quartos, '
              'Area: ${data.property.buildingArea} m²',
            ),
            pw.SizedBox(height: 10),
            pw.Text('Detalhes da Transacao:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(
              'Valor Total: ${_formatCurrency(data.property.price)}, '
              'Data de Pagamento: ${_formatDate(data.createdAt)}',
            ),
            pw.SizedBox(height: 10),
            pw.Text('Forma de Pagamento:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(
                'Metodo: ${_sanitizeText(data.property.paymentModality)}, '),
            pw.SizedBox(height: 20),
            pw.Text('Condicoes Especiais:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(
              'O imovel sera transferido livre e desembaracado de quaisquer onus.',
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
                  pw.Text('Comprador')
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
                  pw.Text('Vendedor')
                ]),
              ],
            ),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/contrato_compra_${data.pkContract}.pdf');
    await file.writeAsBytes(await pdf.save());

    await OpenFile.open(file.path);
  }

  static String _sanitizeText(String input) {
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
