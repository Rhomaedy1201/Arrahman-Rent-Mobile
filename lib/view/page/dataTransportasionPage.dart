import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:transportation_rent_mobile/controllers/qutationController.dart';
import 'package:transportation_rent_mobile/pdf/invoicePdf.dart';
import 'package:transportation_rent_mobile/pdf/quotationPdf.dart';
import 'package:transportation_rent_mobile/utils/base_url.dart';
import 'package:transportation_rent_mobile/view/page/addTransportationPage.dart';
import 'package:transportation_rent_mobile/widget/dataQuotation.dart';
import 'package:transportation_rent_mobile/widget/snackbarWidget.dart';

class DataTransportationPage extends StatefulWidget {
  int id_customer;
  DataTransportationPage({super.key, required this.id_customer});

  @override
  State<DataTransportationPage> createState() => _DataTransportationPageState();
}

class _DataTransportationPageState extends State<DataTransportationPage> {
  List<String> nameData = [
    "Nama",
    "No Hanphone",
    "Nama Perusahaan",
    "Kota/Pos",
    "Alamat",
    "Email",
  ];
  List<String> dataQuotation2 = [
    "Ibu Karina",
    "+62 (31) 8431 699",
    "PT Philip Morris Sampoerna",
    "Surabaya,60293",
    "Jl. Rungkut Industri Raya No.18",
    "karina.purwiyono@contracted.sampoerna.com",
  ];

  final currencyFormatter =
      NumberFormat.currency(locale: 'ID', symbol: '', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    getQuotation(widget.id_customer);
    getTransportation(widget.id_customer);
    getCompany();
  }

  // Get data Quotation
  var isLoading = false;
  late Map<String, dynamic> dataQuotation;
  void getQuotation(int id_customer) async {
    setState(() {
      isLoading = true;
    });
    String url = "$baseUrl/transportation/$id_customer";

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataQuotation = json.decode(response.body)['customer'][0];
        // print(dataQuotation);
      } else {
        print(response.body);
      }
    } catch (e) {
      // SnackbarWidget().snackbarError(
      //     "Server Ada kendala atau mati, silahkan hubungi pihak pengembang");
      print(e);
    }
    // print(dataQuotation['id']);
    setState(() {
      isLoading = false;
    });
  }

  // Get Data Transportation
  var isLoading2 = false;
  late Map<String, dynamic> dataTransportation = {};
  List<dynamic> cekTrans = [];
  void getTransportation(int id_customer) async {
    setState(() {
      isLoading2 = true;
    });
    dataTransportation =
        (await QuotationController().getTransportation(id_customer))!;
    cekTrans = dataTransportation['transportation'];
    print("Data = $dataTransportation");

    setState(() {
      isLoading2 = false;
    });
  }

  // Get data Company for pdf Quotation and Invoice
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
        // print(dataCompany['kota']);
      } else {
        print(response.body);
      }
    } catch (e) {
      // SnackbarWidget().snackbarError(
      //     "Server Ada kendala atau mati, silahkan hubungi pihak pengembang");
      print(e);
    }
    // print(dataQuotation['id']);
    setState(() {
      isLoading2 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Data Penyewaan",
          style: TextStyle(fontSize: 18),
        ),
        foregroundColor: Color(0xFF686868),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
      ),
      bottomNavigationBar: Container(
        height: cekTrans.isEmpty ? 65 : 108,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFDCDCDC),
              blurRadius: 4,
              offset: Offset(0, 0), // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    final connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      print("NO INTERNET");
                    } else {
                      Get.to(AddTransportationPage(
                        id_customer: widget.id_customer,
                      ));
                    }
                  },
                  child: const Text(
                    'Tambah Transportasi',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(1),
                    overlayColor: MaterialStateProperty.all(Color(0xFF3EA8D6)),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF5DC3EF)),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              cekTrans.isEmpty
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 130,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              // cek Internet Connection
                              final connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                  ConnectivityResult.none) {
                                print("NO INTERNET");
                              } else {
                                // print Pdf Quotation
                                QuotationPdf().printPdf(
                                  // data company/perusahaan
                                  dataCompany['logo'],
                                  dataCompany['alamat'],
                                  dataCompany['kota'],
                                  dataCompany['no_hp'],
                                  dataCompany['email'],
                                  // orang yang bertanda tangan
                                  dataQuotation['nama_lengkap'],
                                  dataQuotation['tanda_tangan'],
                                  // data customer
                                  widget.id_customer,
                                  dataQuotation['kutipan_sewa'],
                                  dataQuotation['tanggal'],
                                  dataQuotation['no_quotation'],
                                  dataQuotation['nama_customer'],
                                  dataQuotation['email'],
                                  dataQuotation['nama_perusahaan'],
                                  dataQuotation['nama_jalan'],
                                  dataQuotation['kota'],
                                  dataQuotation['kode_pos'],
                                  dataQuotation['no_hp'],
                                  dataQuotation['komentar'],
                                );
                              }
                            },
                            child: Text('Print Quotation',
                                style: TextStyle(fontSize: 12)),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(1),
                              overlayColor:
                                  MaterialStateProperty.all(Color(0xFFC34E4E)),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFED6C6C)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 130,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              // cek internet connection
                              final connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                  ConnectivityResult.none) {
                                print("NO INTERNET");
                              } else {
                                //print invoice pdf
                                InvoicePdf().printPdf();
                              }
                            },
                            child: Text('Print Invoice',
                                style: TextStyle(fontSize: 12)),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(1),
                              overlayColor:
                                  MaterialStateProperty.all(Color(0xFFC34E4E)),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFED6C6C)),
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
      body: isLoading
          ? Center(child: Text("Loading"))
          : isLoading2
              ? Center(child: Text("Loading"))
              : ListView(
                  shrinkWrap: true,
                  physics: cekTrans.isEmpty
                      ? const NeverScrollableScrollPhysics()
                      : const AlwaysScrollableScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return DataQuotation().data(
                              dataQuotation['nama_customer'],
                              dataQuotation['no_hp'],
                              dataQuotation['nama_perusahaan'],
                              dataQuotation['kota'],
                              dataQuotation['kode_pos'],
                              dataQuotation['nama_jalan'],
                              dataQuotation['email'],
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: cekTrans.isEmpty
                              ? Column(
                                  children: const [
                                    SizedBox(height: 200),
                                    Text("Transportation Masih Kosong!"),
                                    Text(
                                      "Silahkan Tambahkan Transportation\nTerlebih dahulu.",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cekTrans.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Container(
                                          width: double.infinity,
                                          height: 128,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xFFB6B6B6)),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: Color(0xFFFFFFFF),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 31,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(7),
                                                          topRight:
                                                              Radius.circular(
                                                                  7)),
                                                  color: Color(0xFFC3EDFF),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15),
                                                      child: Text(
                                                        '${cekTrans[index]['tipe_mobil']}'
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 1,
                                                color: Color(0xFFB6B6B6),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                  vertical: 8,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Tanggal Penggunaan",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF616161),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          "9-Feb-2023",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF616161),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 3),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Lama Penggunaan",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF616161),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          cekTrans[index][
                                                              'lama_penggunaan'],
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF616161),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 3),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Jumlah",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF616161),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${cekTrans[index]['jumlah']} Unit",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF616161),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 1,
                                                      color: Color(0xFFB6B6B6),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(""),
                                                        Text(
                                                          "Rp. ${currencyFormatter.format(double.parse(cekTrans[index]['harga'])).replaceAll('.', ',')}",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF616161),
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
    );
  }
}
