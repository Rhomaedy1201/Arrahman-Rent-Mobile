import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:transportation_rent_mobile/pdf/invoicePdf.dart';
import 'package:transportation_rent_mobile/utils/base_url.dart';
import 'package:transportation_rent_mobile/view/history/historyInvoiceOnly.dart';
import 'package:transportation_rent_mobile/widget/itemDetailInvoice.dart';

class DetailDataInvoiceOnly extends StatefulWidget {
  const DetailDataInvoiceOnly({super.key});

  @override
  State<DetailDataInvoiceOnly> createState() => _DetailDataInvoiceOnlyState();
}

class _DetailDataInvoiceOnlyState extends State<DetailDataInvoiceOnly> {
  @override
  void initState() {
    super.initState();
    getInvoceOnly(1);
    getCompany();
  }

  // Get data Invoice
  int subTotalRp = 0;
  var isLoading = false;
  List<dynamic> dataInvoice = [];

  void getInvoceOnly(int id) async {
    setState(() {
      isLoading = true;
    });
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
    // print(dataInvoice['id']);
    setState(() {
      isLoading = false;
    });
  }

  var isLoading2 = false;
  late Map<String, dynamic> dataCompany;
  void getCompany() async {
    setState(() {
      isLoading2 = true;
    });
    String url = "$baseUrl/data-company";

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataCompany = json.decode(response.body)['data'][0];
        print(dataCompany);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading2 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Detail Invoice",
            style: TextStyle(fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () {
              Get.offAll(const HistoryInvoiceOnly());
            },
            icon: const Icon(Icons.arrow_back),
          ),
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
            : isLoading2
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
                              dataInvoice[index]['nama_bank'],
                              dataInvoice[index]['nama_tanda_tangan'],
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFED6C6C),
                                ),
                                onPressed: () async {
                                  final connectivityResult =
                                      await (Connectivity()
                                          .checkConnectivity());
                                  if (connectivityResult ==
                                      ConnectivityResult.none) {
                                    print("NO INTERNET");
                                  } else {
                                    InvoicePdf().printPdf(
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
                                      dataInvoice[index]['nama_bank'],
                                      dataInvoice[index]['no_rekening'],
                                      dataInvoice[index]['a_n_rekening'],
                                      dataInvoice[index]['nama_tanda_tangan'],
                                      subTotalRp,
                                    );
                                  }
                                },
                                child: const Text(
                                  "Generate Invoice",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ));
  }
}
