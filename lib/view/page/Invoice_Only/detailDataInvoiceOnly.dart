import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:transportation_rent_mobile/pdf/invoicePdf.dart';
import 'package:transportation_rent_mobile/utils/base_url.dart';
import 'package:transportation_rent_mobile/view/history/historyInvoiceOnly.dart';
import 'package:transportation_rent_mobile/view/page/Invoice_Only/addDataInvoiceOnly.dart';
import 'package:transportation_rent_mobile/widget/itemDetailInvoice.dart';

class DetailDataInvoiceOnly extends StatefulWidget {
  int id;
  DetailDataInvoiceOnly({super.key, required this.id});

  @override
  State<DetailDataInvoiceOnly> createState() => _DetailDataInvoiceOnlyState();
}

class _DetailDataInvoiceOnlyState extends State<DetailDataInvoiceOnly> {
  bool _isPopupVisible = false;
  @override
  void initState() {
    super.initState();
    getInvoceOnlyAndCompay(widget.id);
  }

  // Get data Invoice
  int subTotalRp = 0;
  var isLoading = false;
  List<dynamic> dataInvoice = [];
  late Map<String, dynamic> dataCompany;

  void getInvoceOnlyAndCompay(int id) async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    // get data company
    String url2 = "$baseUrl/data-company";
    try {
      http.Response response = await http
          .get(Uri.parse(url2), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataCompany = json.decode(response.body)['data'][0];
        print(dataCompany);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }

    // get invoice only
    String url = "$baseUrl/invoce-only/$id";
    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataInvoice = json.decode(response.body)['data'];
        for (var i = 0; i < dataInvoice.length; i++) {
          subTotalRp += int.parse(dataInvoice[i]['total_pembayaran']);
        }
        print('alskdjklasjd ${dataInvoice}');
      } else {
        print(response.body);
      }
    } catch (e) {
      print("Server");
    }

    if (mounted)
      setState(() {
        isLoading = false;
      });
  }

  // Filter
  void _togglePopupVisibility(
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
  ) {
    if (mounted) {
      setState(() {
        _isPopupVisible = !_isPopupVisible;
      });
    }
    if (_isPopupVisible) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                actions: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 45,
                        color: const Color(0xFFD0EDF9),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Pilih",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (mounted) {
                                        setState(() {
                                          _isPopupVisible = !_isPopupVisible;
                                        });
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFFFC0C0),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Icon(
                                        Icons.close,
                                        size: 15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFED6C6C),
                                ),
                                onPressed: () {
                                  InvoicePdf().printPdf(
                                    logo_company,
                                    alamat_company,
                                    kota_company,
                                    phone_company,
                                    email_company,
                                    nama_company,
                                    nomor_invoice,
                                    tanggal_invoice,
                                    exportedImage,
                                    tanda_penerima_pembayaran,
                                    keterangan,
                                    periode_pembayaran,
                                    metode_pembayaran,
                                    nama_bank,
                                    noRekening,
                                    nama_rekening,
                                    nama_tanda_tangan,
                                    subTotalRp,
                                    true,
                                  );
                                  if (mounted) {
                                    setState(() {
                                      _isPopupVisible = !_isPopupVisible;
                                    });
                                  }
                                  Get.back();
                                },
                                label: const Text("Generate Invoice"),
                                icon: const Icon(Icons.picture_as_pdf),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFED6C6C),
                                ),
                                onPressed: () {
                                  InvoicePdf().printPdf(
                                    logo_company,
                                    alamat_company,
                                    kota_company,
                                    phone_company,
                                    email_company,
                                    nama_company,
                                    nomor_invoice,
                                    tanggal_invoice,
                                    exportedImage,
                                    tanda_penerima_pembayaran,
                                    keterangan,
                                    periode_pembayaran,
                                    metode_pembayaran,
                                    nama_bank,
                                    noRekening,
                                    nama_rekening,
                                    nama_tanda_tangan,
                                    subTotalRp,
                                    false,
                                  );
                                  if (mounted) {
                                    setState(() {
                                      _isPopupVisible = !_isPopupVisible;
                                    });
                                  }
                                  Get.back();
                                },
                                label: const Text("Share Invoice"),
                                icon: const Icon(Icons.share),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Detail Invoice",
            style: TextStyle(fontSize: 18),
          ),
          // leading: IconButton(
          //   onPressed: () {
          //     Get.offAll(const HistoryInvoiceOnly());
          //   },
          //   icon: const Icon(Icons.arrow_back),
          // ),
          foregroundColor: const Color(0xFF686868),
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 1,
        ),
        body: isLoading
            ? Center(
                child: Container(
                  width: 60,
                  height: 60,
                  child: Lottie.asset('assets/lottie/loading.json'),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dataInvoice.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      children: [
                        ItemDetailInvoice().item_detail_invoice(
                          dataInvoice[index]['nomor_invoice'],
                          dataInvoice[index]['tanggal_invoice'],
                          dataInvoice[index]['total_pembayaran'],
                          dataInvoice[index]['periode_pembayaran'],
                          dataInvoice[index]['metode_pembayaran'],
                          dataInvoice[index]['nama_bank'] == null
                              ? "kosong"
                              : dataInvoice[index]['nama_bank'],
                          dataInvoice[index]['nama_tanda_tangan'],
                        ),
                        const SizedBox(height: 15),
                        // SizedBox(
                        //   width: double.infinity,
                        //   height: 40,
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: const Color(0xFFED6C6C),
                        //     ),
                        //     onPressed: () async {},
                        //     child: const Text(
                        //       "Generate Invoice",
                        //       style: TextStyle(
                        //         fontSize: 14,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 5,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFED6C6C),
                              ),
                              onPressed: () async {
                                final connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult ==
                                    ConnectivityResult.none) {
                                  debugPrint("NO INTERNET");
                                } else {
                                  _togglePopupVisibility(
                                    dataCompany['logo'],
                                    dataCompany['alamat'],
                                    dataCompany['kota'],
                                    dataCompany['no_hp'],
                                    dataCompany['email'],
                                    dataCompany['nama_company'],
                                    //
                                    dataInvoice[index]['nomor_invoice'],
                                    dataInvoice[index]['tanggal_invoice'],
                                    dataInvoice[index]['img_tanda_tangan'],
                                    dataInvoice[index]
                                        ['tanda_penerima_pembayaran'],
                                    dataInvoice[index]['keterangan'],
                                    dataInvoice[index]['periode_pembayaran'],
                                    dataInvoice[index]['metode_pembayaran'],
                                    dataInvoice[index]['nama_bank'] == null
                                        ? 'null'
                                        : dataInvoice[index]['nama_bank'],
                                    dataInvoice[index]['no_rekening'] == null
                                        ? 'null'
                                        : dataInvoice[index]['no_rekening'],
                                    dataInvoice[index]['a_n_rekening'] == null
                                        ? 'null'
                                        : dataInvoice[index]['a_n_rekening'],
                                    dataInvoice[index]['nama_tanda_tangan'],
                                    subTotalRp,
                                  );
                                }
                              },
                              child: const Text("Generate Invoice"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(AddDataInvoiceOnly(
                                    idInvoiceOnly: dataInvoice[index]['id']));
                              },
                              child: const Text("Edit Invoice"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ));
  }
}
