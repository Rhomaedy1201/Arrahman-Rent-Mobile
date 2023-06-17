import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:transportation_rent_mobile/controllers/qutationController.dart';
import 'package:transportation_rent_mobile/utils/base_url.dart';

class QuotationPdf {
  Future<void> printPdf(
    // Data Company
    String logo_company,
    String alamat_company,
    String kota_company,
    String phone_company,
    String email_company,
    // yang bertanda tangan
    String nama_ttd,
    String img_ttd,
    // Data customer
    int id_customer,
    String kutipan,
    String tanggal,
    String nomor_kutipan,
    String nama_customer,
    String email_customer,
    String nama_perusahaan_customer,
    String alamat_customer,
    String kota_customer,
    String kodePos_customer,
    String phone_customer,
    String? komenar_customer,
  ) async {
    final pdf = pw.Document();

    // number format
    final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: '');

    // convert to original date
    final inputFormat = DateFormat('yyyy-MM-dd');
    final dateTime = inputFormat.parseStrict(tanggal);
    final outputFormat = DateFormat('dd/MM/yyyy');
    String originalDate = outputFormat.format(dateTime);

    // get image from api server
    final url = '$urlWeb/storage/ttd/$img_ttd'; // Replace with your image URL
    final response = await http.get(Uri.parse(url));
    final bytes_ttd = response.bodyBytes;

    // get image from api server
    final url_logo_company =
        '$urlWeb/storage/$logo_company'; // Replace with your image URL
    final response_logo_company = await http.get(Uri.parse(url_logo_company));
    final bytes_logo_company = response_logo_company.bodyBytes;

    // get Api table data Transportation
    late Map<String, dynamic> dataTransportation = {};
    List<dynamic> cekTrans = [];
    dataTransportation =
        (await QuotationController().getTransportation(id_customer))!;
    cekTrans = dataTransportation['transportation'];
    var list1 = List<dynamic>.from(cekTrans);
    print("Data = ${cekTrans.length}");
    // menjumlahkan seluruh harga
    int jmlSemua = 0;
    for (var i = 0; i < cekTrans.length; i++) {
      jmlSemua += int.parse(cekTrans[i]['harga']);
    }

    //table
    final tableData = [
      [
        'Tanggal digunakan',
        'Tempat Tujuan',
        'Tipe Mobil',
        'Jumlah',
        'Harga',
      ],
    ];

    final tableTotal = [
      [
        'Total',
        'Rp. ${currencyFormatter.format(double.parse(jmlSemua.toString())).replaceAll('.', ',')}',
      ],
    ];

    final headers = tableData.removeAt(0);
    final total = tableTotal.removeAt(0);

    final dataTableApi = pw.ListView.builder(
      itemBuilder: (context, index) {
        return pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {
            0: pw.FlexColumnWidth(1.5),
            1: pw.FlexColumnWidth(2.5),
            2: pw.FlexColumnWidth(1),
            3: pw.FlexColumnWidth(0.7),
            4: pw.FlexColumnWidth(2),
          },
          children: [
            pw.TableRow(children: [
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      '${cekTrans[index]['tanggal_penggunaan']}',
                      style: const pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Row(
                  children: [
                    pw.Text(
                      '${cekTrans[index]['tujuan']} dalam waktu ${cekTrans[index]['lama_penggunaan']}',
                      style: const pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      '${cekTrans[index]['tipe_mobil']}',
                      style: const pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      '${cekTrans[index]['jumlah']}',
                      style: const pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "Rp. ${currencyFormatter.format(double.parse(cekTrans[index]['harga'])).replaceAll('.', ',')}",
                      style: const pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        );
      },
      itemCount: cekTrans.length,
    );

    final table = pw.Table(
      border: pw.TableBorder.all(),
      columnWidths: {
        0: pw.FlexColumnWidth(1.5),
        1: pw.FlexColumnWidth(2.5),
        2: pw.FlexColumnWidth(1),
        3: pw.FlexColumnWidth(0.7),
        4: pw.FlexColumnWidth(2),
      },
      children: [
        pw.TableRow(
          children: headers.map((header) {
            return pw.Container(
              padding: const pw.EdgeInsets.all(5),
              color: PdfColors.grey300, // Set header background color here
              child: pw.Text(
                header,
                textAlign:
                    headers.indexOf(header) == 1 ? null : pw.TextAlign.center,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black,
                  fontSize: 10,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );

    final tableTotalPrice = pw.Table(
      border: pw.TableBorder.all(),
      columnWidths: {
        0: pw.FlexColumnWidth(5.7),
        1: pw.FlexColumnWidth(2),
      },
      children: [
        pw.TableRow(
          children: total.map((total) {
            return pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                total,
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(
                  color: PdfColors.black,
                  fontSize: 10,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );

    // data customer
    var dataCustomer = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "Kutipan Untuk: ${kutipan}",
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        pw.Text(nama_customer),
        pw.SizedBox(height: 10),
        pw.Text(email_customer),
        pw.SizedBox(height: 3),
        pw.Text(nama_perusahaan_customer),
        pw.SizedBox(height: 3),
        pw.Text(alamat_customer),
        pw.SizedBox(height: 3),
        pw.Text("${kota_customer},${kodePos_customer}"),
        pw.SizedBox(height: 3),
        pw.Text("Phone +${phone_customer}"),
        pw.SizedBox(height: 3),
        pw.Row(children: [
          pw.Text(
            "Komentar atau Instruksi Khusus:",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(width: 7),
          pw.Text(komenar_customer == null ? "None." : komenar_customer),
        ]),
        pw.SizedBox(height: 10),
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(horizontal: 10),
          child: pw.Text("Dear $nama_customer,"),
        ),
      ],
    );

    // Add a page to the PDF
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.symmetric(vertical: 35, horizontal: 30),
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
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 0),
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          // color: PdfColors.amber,
                          width: 350,
                          child: pw.Text(alamat_company),
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              "Tanggal  ",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(originalDate),
                          ],
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 3),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(kota_company),
                        pw.Row(
                          children: [
                            pw.Text(
                              "No Kutipan #  ",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(nomor_kutipan),
                          ],
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 3),
                    pw.Text("Phone: $phone_company"),
                    pw.SizedBox(height: 3),
                    pw.Text("Email: $email_company"),
                    pw.SizedBox(height: 3),
                    // data customer
                    dataCustomer,
                    // end data customer

                    // data table transpotation
                    pw.SizedBox(height: 10),
                    pw.Text(
                        "Mengenai pertanyaan Anda tentang penawaran layanan transportasi kami, dengan ini kami ingin menginformasikan tarif transportasi kami di bawah ini:"),
                  ],
                ),
              ),
              pw.SizedBox(height: 10),
              table,
              dataTableApi,
              tableTotalPrice,
              pw.SizedBox(height: 10),
              pw.Text(
                "Syarat dan ketentuan: ",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 5),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 3),
                    pw.Text(
                        "· Harga sudah termasuk bensin, tol, dan biaya parkir"),
                    pw.SizedBox(height: 3),
                    pw.Text("· Harga belum termasuk PPN 11%"),
                    pw.SizedBox(height: 3),
                    pw.Text(
                        "· Jika pelanggan meminta pembatalan setelah mobil diantar, pelanggan akan dikenakan biaya pembatalan 100% dari tarif sewa"),
                    pw.SizedBox(height: 3),
                    pw.Text(
                        "· Kami dapat menyediakan 8 unit Alphard pada waktu yang disebutkan Terima kasih atas perhatiannya, jika ada pertanyaan mengenai penawaran ini, jangan ragu untuk menghubungi kami di +62-822-3234-5232."),
                  ],
                ),
              ),
              pw.SizedBox(height: 7),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 10),
                    child: pw.Column(
                      children: [
                        pw.Text("Dengan hormat,"),
                        pw.SizedBox(
                          width: 50,
                          height: 50,
                          child: pw.Image(pw.MemoryImage(bytes_ttd)),
                        ),
                        pw.Text(nama_ttd),
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
    final file =
        File('${output.path}/Quotation-${nama_perusahaan_customer}.pdf');
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);

    print('PDF saved to ${file.path}');
  }
}
