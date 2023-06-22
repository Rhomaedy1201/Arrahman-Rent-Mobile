import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:transportation_rent_mobile/controllers/qutationController.dart';
import 'package:transportation_rent_mobile/utils/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:transportation_rent_mobile/utils/convertNumberToLatters.dart';
import 'package:transportation_rent_mobile/utils/convertOriginalDate.dart';

class InvoicePdf {
  Future<void> printPdf(
    String logo_company,
    String alamat_company,
    String kota_company,
    String phone_company,
    String email_company,
    String nama_company,
    //
    String nomor_invoice,
    String tanggal_invoice,
    String exportedImage,
    String tanda_penerima_pembayaran,
    String keterangan,
    String periode_pembayaran,
    String metode_pembayaran,
    String nama_bank,
    String noRekening,
    String nama_rekening,
    String nama_tanda_tangan,
    int subTotalRp,
  ) async {
    final pdf = pw.Document();
    // get image logo company from api server
    final url_logo_company = '$urlWeb/public/storage/$logo_company';
    // final url_logo_company = '$urlWeb/storage/$logo_company';
    final response_logo_company = await http.get(Uri.parse(url_logo_company));
    final bytes_logo_company = response_logo_company.bodyBytes;

    //format phone Company
    String? formattedPhoneCompany;
    if (phone_company.contains('[') && phone_company.contains(']')) {
      formattedPhoneCompany =
          phone_company.replaceRange(5, 5, ' ').replaceRange(9, 9, ' ');
    } else {
      formattedPhoneCompany = phone_company.replaceAllMapped(
          RegExp(r".{4}"), (match) => "${match.group(0)} ");
    }

    // get image from api server
    final url = '$urlWeb/public/storage/$exportedImage';
    // final url = '$urlWeb/storage/$exportedImage';
    final response = await http.get(Uri.parse(url));
    final bytes_ttd = response.bodyBytes;

    // Convert original date
    String originalDateInvoice =
        ConvertOriginalDate().dateFormat(tanggal_invoice);
    String originalDateAddMonth =
        ConvertOriginalDate().dateFormatNameMont(tanggal_invoice);

    // number format
    final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: '');

    // PPN
    var resultPpn = (11 / 100) * subTotalRp;

    // Total
    int total = (subTotalRp + resultPpn).toInt();

    final header = [
      ['Tanda Terima Pembayaran'],
    ];
    final header2 = [
      [
        'Keterangan',
        'Total',
      ],
    ];
    final ketData = [
      [
        '$keterangan Periode Pembayaran $periode_pembayaran',
        'Rp ${currencyFormatter.format(double.parse(subTotalRp.toString()))}',
      ],
    ];

    final headersTandaTerima = header.removeAt(0);
    final keteranganHeader = header2.removeAt(0);
    final dataKeteranganHeader = ketData.removeAt(0);

    final tandaTerimaPembayaran = pw.Table(
      columnWidths: {
        0: pw.FlexColumnWidth(1),
      },
      children: [
        pw.TableRow(
          children: headersTandaTerima.map((total) {
            return pw.Container(
              height: 20,
              color: PdfColors.grey300,
              child: pw.Center(
                child: pw.Text(
                  total,
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        // ...rows,
      ],
    );

    final keteranganTableHeader = pw.Table(
      border: pw.TableBorder.all(width: 1),
      columnWidths: {
        0: pw.FlexColumnWidth(2.5),
        1: pw.FlexColumnWidth(1),
      },
      children: [
        pw.TableRow(
          children: keteranganHeader.map((total) {
            return pw.Container(
              height: 20,
              color: PdfColors.grey300,
              child: pw.Center(
                child: pw.Text(
                  total,
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        pw.TableRow(
          children: dataKeteranganHeader.map((total) {
            return pw.Container(
              child: pw.Padding(
                padding: pw.EdgeInsets.all(15),
                child: pw.Center(
                  child: pw.Text(
                    total,
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        // ...rows,
      ],
    );

    final rincianKendaraan = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text("Sebagaimana Rincian Kendaraan Terlampir"),
        pw.SizedBox(height: 5),
        pw.Container(
          width: 300,
          height: 20,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey300,
            border: pw.Border.all(width: 1),
          ),
          child: pw.Padding(
            padding: const pw.EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 3,
            ),
            child: pw.Text("Terbilang"),
          ),
        ),
        pw.Container(
            width: 300,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 1),
            ),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child:
                  pw.Text("${ConvertNumberToLatters().numberToLetters(total)}"),
            )),
      ],
    );

    // Subtotal kanan
    final subTotal = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 200,
          height: 13,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                width: 70,
                child: pw.Text(
                  "Subtotal",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                "Rp ${currencyFormatter.format(double.parse(subTotalRp.toString()))}",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Container(
          width: 200,
          height: 13,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                width: 70,
                child: pw.Text(
                  "PPN",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                "11%",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Container(
          width: 200,
          height: 13,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                width: 70,
                child: pw.Text(''),
              ),
              pw.Text(
                "Rp ${currencyFormatter.format(double.parse(resultPpn.toString()))}",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Container(
          width: 200,
          height: 1,
          color: PdfColors.black,
        ),
        pw.SizedBox(height: 5),
        pw.Container(
          width: 200,
          height: 13,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                width: 70,
                child: pw.Text(
                  'Total',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              pw.Text(
                "Rp ${currencyFormatter.format(double.parse(total.toString()))}",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        build: (pw.Context context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.SizedBox(
                    width: 200,
                    height: 150,
                    child: pw.Image(pw.MemoryImage(bytes_logo_company)),
                  ),
                ],
              ),
              pw.Divider(
                thickness: 2,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Container(
                    width: 360,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 3),
                        pw.Text(alamat_company),
                        pw.SizedBox(height: 3),
                        pw.Text(kota_company),
                        pw.SizedBox(height: 3),
                        pw.Text("Phone: +62 $formattedPhoneCompany"),
                        pw.SizedBox(height: 3),
                        pw.Text("E-Mail: $email_company"),
                      ],
                    ),
                  ),
                  pw.Row(
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.SizedBox(height: 3),
                          pw.Text("Tanggal"),
                          pw.SizedBox(height: 3),
                          pw.Text("No."),
                        ],
                      ),
                      pw.SizedBox(width: 10),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: 70,
                            height: 16,
                            decoration: pw.BoxDecoration(
                              // color: PdfColors.red,
                              border: pw.Border.all(
                                color: PdfColors.black,
                                width: 1,
                              ),
                            ),
                            child: pw.Center(
                              child: pw.Text(originalDateInvoice),
                            ),
                          ),
                          pw.Container(
                            width: 70,
                            height: 16,
                            decoration: pw.BoxDecoration(
                              // color: PdfColors.red,
                              border: pw.Border.all(
                                color: PdfColors.black,
                                width: 1,
                              ),
                            ),
                            child: pw.Center(
                              child: pw.Text(nomor_invoice),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              tandaTerimaPembayaran,
              pw.Container(
                width: double.infinity,
                height: 75,
                // color: PdfColors.amber,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20),
                  child: pw.Text(
                      "Telah Terima Dari : ${tanda_penerima_pembayaran == 'null' ? '' : tanda_penerima_pembayaran}"),
                ),
              ),
              keteranganTableHeader,
              pw.SizedBox(height: 5),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  // Rincian Kendaraan
                  rincianKendaraan,

                  // Subtotal
                  subTotal,
                ],
              ),

              // Pembayaran dan form ttd
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  //form pembayaran
                  pw.Container(
                    width: 300,
                    // color: PdfColors.amber,
                    child: pw.Padding(
                      padding: pw.EdgeInsets.all(10),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Pembayaran : "),
                          pw.SizedBox(height: 10),
                          pw.Row(
                            children: [
                              pw.Container(
                                width: 12,
                                height: 12,
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(width: 1),
                                ),
                                child: pw.Center(
                                  child: pw.Text(
                                      metode_pembayaran == "cash" ? "V" : ""),
                                ),
                              ),
                              pw.SizedBox(width: 10),
                              pw.Text("Cash"),
                            ],
                          ),
                          pw.SizedBox(height: 5),
                          pw.Row(
                            children: [
                              pw.Container(
                                width: 12,
                                height: 12,
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(width: 1),
                                ),
                                child: pw.Center(
                                  child: pw.Text(
                                      metode_pembayaran == "cash" ? "" : "V"),
                                ),
                              ),
                              pw.SizedBox(width: 10),
                              pw.Text(
                                  "Transfer melalui : ${nama_bank == 'null' ? '' : nama_bank}"),
                            ],
                          ),
                          pw.SizedBox(height: 5),
                          pw.Container(
                            width: 250,
                            margin: pw.EdgeInsets.only(left: 24),
                            // color: PdfColors.red,
                            child: pw.Text(
                                "No. Rekening : ${noRekening == 'null' ? '' : noRekening}"),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Container(
                            width: 250,
                            // color: PdfColors.red,
                            margin: pw.EdgeInsets.only(left: 24),
                            child: pw.Text(
                                "a/n : ${nama_rekening == 'null' ? '' : nama_rekening}"),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // form ttd
                  pw.Container(
                    width: 200,
                    // color: PdfColors.red,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                            horizontal: 0,
                            // vertical: 10,
                          ),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("$kota_company, $originalDateAddMonth"),
                                pw.SizedBox(height: 10),
                                pw.Text(nama_company),
                              ]),
                        ),
                        pw.SizedBox(height: 20),
                        pw.Center(
                          child: pw.Container(
                            width: 100,
                            height: 50,
                            // color: PdfColors.amber,
                            child: pw.Image(
                              pw.MemoryImage(bytes_ttd),
                            ),
                          ),
                        ),
                        // pw.SizedBox(height: 3),
                        pw.Text(nama_tanda_tangan),
                        pw.Container(
                          width: 230,
                          height: 1,
                          color: PdfColors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    // Save the PDF to a file
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/Invoice.pdf');
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);

    print('PDF saved to ${file.path}');
  }
}
