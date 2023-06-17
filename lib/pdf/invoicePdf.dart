import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class InvoicePdf {
  Future<void> printPdf() async {
    final pdf = pw.Document();
    final ByteData imageData = await rootBundle.load('assets/logo/logo.png');
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    final image = pw.MemoryImage(imageBytes);

    final header = [
      ['Tanggal digunakan'],
    ];
    final header2 = [
      [
        'Keterangan',
        'Total',
      ],
    ];
    final ketData = [
      [
        'Sewa 2 (dua) unit Kendaraan Roda 4 (empat) periode pembayaran bulan Januari 2022',
        'Rp. 18,350,000.00',
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
            padding: pw.EdgeInsets.symmetric(
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
              padding: pw.EdgeInsets.all(10),
              child: pw.Text(
                  "Dua Puluh Juta Seratus Delapan Puluh Lima Ribu Rupiah"),
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
                "Rp. 18,350,000.00",
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
                  "PPn",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                "10%",
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
                "Rp. 1,835,000.00",
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
                "Rp. 20,185,000.00",
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
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.SizedBox(
                    width: 200,
                    height: 150,
                    child: pw.Image(image),
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
                        pw.Text(
                            "Wisma Kedung Asem Indah Blok C No 13 RT 002 RW 005"),
                        pw.SizedBox(height: 3),
                        pw.Text("Surabaya"),
                        pw.SizedBox(height: 3),
                        pw.Text("Phone: [031] 870 4740"),
                        pw.SizedBox(height: 3),
                        pw.Text("E-Mail: suhulgroup@gmail.com"),
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
                              child: pw.Text("1/01/2002"),
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
                              child: pw.Text("'012112001"),
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
                  padding:
                      pw.EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: pw.Text("Telah Terima Dari :"),
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
                              ),
                              pw.SizedBox(width: 10),
                              pw.Text("Transfer melalui............."),
                            ],
                          ),
                          pw.SizedBox(height: 5),
                          pw.Row(
                            children: [
                              pw.Container(
                                width: 12,
                                height: 12,
                              ),
                              pw.SizedBox(width: 10),
                              pw.Row(
                                children: [
                                  pw.Container(
                                    width: 200,
                                    // color: PdfColors.red,
                                    child: pw.Text("No. Rekening :"),
                                  ),
                                  pw.Text("a/n ......"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // form ttd
                  pw.Container(
                    width: 230,
                    // color: PdfColors.red,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Surabaya,14 Januari 2022"),
                                pw.SizedBox(height: 10),
                                pw.Text("PT Suhul Mabrouk Arrahmah,"),
                              ]),
                        ),
                        pw.SizedBox(height: 100),
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
          );
        },
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
