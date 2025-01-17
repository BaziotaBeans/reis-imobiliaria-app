import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:intl/intl.dart';
import 'package:reis_imovel_app/dto/Payment.dart';
import 'package:reis_imovel_app/utils/app_utils.dart';

class PaymentPdfGenerator {
  static Future<void> generateAndDownloadPdf(Payment payment) async {
    final pdf = pw.Document();

    // Create PDF content
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      'Comprovativo de Pagamento',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 20),
                  ],
                ),
              ),

              // Payment Details
              pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                  borderRadius:
                      const pw.BorderRadius.all(pw.Radius.circular(10)),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildPdfRow('Valor Total:',
                        '${payment.totalValue.toStringAsFixed(2)} kz',
                        isBold: true),
                    pw.Divider(),
                    _buildPdfRow('Nº Referência:', payment.reference),
                    _buildPdfRow('Método de Pagamento:',
                        payment.paymentMethod ?? 'Multicaixa Express'),
                    _buildPdfRow(
                        'Tipo Item:',
                        AppUtils.getPropertyType(payment.property) ??
                            'Locação'),
                    _buildPdfRow(
                        'Data:', _formatDateTime(payment.createdAt)['date']!),
                    _buildPdfRow(
                        'Hora:', _formatDateTime(payment.createdAt)['time']!),
                    _buildPdfRow('Responsável:', payment.user.fullName),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),

              // Property Details
              pw.Text(
                'Detalhes do Imóvel',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                  borderRadius:
                      const pw.BorderRadius.all(pw.Radius.circular(10)),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildPdfRow('Nome:', payment.property.title),
                    _buildPdfRow('Localização:', payment.property.address),
                    if (payment.property.description != null)
                      _buildPdfRow('Descrição:', payment.property.description!),
                  ],
                ),
              ),

              // Footer
              pw.Expanded(
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Divider(),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      'Este documento é um comprovativo digital de pagamento.',
                      style: const pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      'Data de emissão: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}',
                      style: const pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    // Get directory for saving pdf
    final output = await getTemporaryDirectory();
    final String fileName =
        'pagamento_${payment.reference}_${DateFormat('ddMMyyyyHHmm').format(DateTime.now())}.pdf';
    final file = File('${output.path}/$fileName');

    // Save PDF
    await file.writeAsBytes(await pdf.save());

    // Open the PDF file
    await OpenFile.open(file.path);
  }

  static pw.Widget _buildPdfRow(String label, String value,
      {bool isBold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              color: PdfColors.grey800,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontWeight: isBold ? pw.FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }

  static Map<String, String> _formatDateTime(String dateTimeStr) {
    final dateTime = DateTime.parse(dateTimeStr);
    final date = DateFormat('dd MMM, yyyy').format(dateTime);
    final time = DateFormat('hh:mm a').format(dateTime);
    return {
      'date': date,
      'time': time,
    };
  }
}
