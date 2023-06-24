import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:transportation_rent_mobile/pdf/invoicePdf.dart';
import 'package:transportation_rent_mobile/pdf/quotationPdf.dart';
import 'package:transportation_rent_mobile/utils/base_url.dart';
import 'package:transportation_rent_mobile/view/history/searchDataHistory.dart';
import 'package:transportation_rent_mobile/view/page/Invoice/addDataInvoice.dart';
import 'package:transportation_rent_mobile/view/page/Transportation/addTransportationPage.dart';
import 'package:transportation_rent_mobile/view/page/Quotation/editQuotationPage.dart';
import 'package:transportation_rent_mobile/view/page/Transportation/editTransportation.dart';
import 'package:transportation_rent_mobile/view/page/homePage.dart';
import 'package:transportation_rent_mobile/widget/dataQuotation.dart';
import 'package:transportation_rent_mobile/widget/materialDialogWidget.dart';
import 'package:transportation_rent_mobile/widget/snackbarWidget.dart';

class DataTransportationPage extends StatefulWidget {
  int id_customer;
  String isBack;
  DataTransportationPage(
      {super.key, required this.id_customer, required this.isBack});

  @override
  State<DataTransportationPage> createState() => _DataTransportationPageState();
}

class _DataTransportationPageState extends State<DataTransportationPage> {
  bool _isPopupVisible = false;

  final currencyFormatter = NumberFormat.currency(locale: 'ID', symbol: '');

  @override
  void initState() {
    super.initState();
    getQuotation(widget.id_customer);
    getTransportation(widget.id_customer);
    getCompany();
    // print(widget.isBack);
  }

  // Get data Quotation
  var isLoading = false;
  late Map<String, dynamic> dataQuotation;
  List<dynamic> invoce = [];
  void getQuotation(int id_customer) async {
    if (mounted)
      setState(() {
        isLoading = true;
      });
    String url = "$baseUrl/transportation/$id_customer";

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataQuotation = json.decode(response.body)['customer'][0];
        invoce = json.decode(response.body)['invoce'];
        // print('CEK ${dataQuotation}');
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    if (mounted)
      setState(() {
        isLoading = false;
      });
  }

  // Get Data Transportation
  int subTotalRp = 0;
  var isLoading2 = false;
  late Map<String, dynamic> dataTransportation = {};
  List<dynamic> cekTrans = [];
  void getTransportation(int id_customer) async {
    if (mounted)
      setState(() {
        isLoading2 = true;
      });
    String url = "$baseUrl/transportation/$id_customer";

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataTransportation = json.decode(response.body)['data'];
        cekTrans = dataTransportation['transportation'];
        // print(cekTrans);
        for (var i = 0; i < cekTrans.length; i++) {
          subTotalRp += int.parse(cekTrans[i]['harga']);
        }
        print("Sub Total = $subTotalRp");
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }

    if (mounted)
      setState(() {
        isLoading2 = false;
      });
  }

  // var list1 = List<dynamic>.from(cekTrans);

  // Get data Company for pdf Quotation and Invoice
  late Map<String, dynamic> dataCompany;
  void getCompany() async {
    if (mounted)
      setState(() {
        isLoading2 = true;
      });
    String url = "$baseUrl/data-company";

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataCompany = json.decode(response.body)['data'][0];
        // print(response.body);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    if (mounted)
      setState(() {
        isLoading2 = false;
      });
  }

  bool isLoadingDelete = false;
  void deleteTransportation(int id) async {
    if (mounted)
      setState(() {
        isLoadingDelete = true;
      });
    String url = "$baseUrl/delete-transportation/$id";

    try {
      http.Response response = await http
          .delete(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var deleteTrans = json.decode(response.body);
        SnackbarWidget().snackbarSuccess("Berhasil Menghapus Transportasi");
        // print(deleteTrans);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    if (mounted)
      setState(() {
        isLoadingDelete = false;
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
    setState(() {
      _isPopupVisible = !_isPopupVisible;
    });
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
                                      setState(() {
                                        _isPopupVisible = !_isPopupVisible;
                                      });
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Data Penyewaan",
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            if (widget.isBack == 'true') {
              Get.offAll(SearchDataHistory());
            } else {
              Get.offAll(HomePage());
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          invoce.isNotEmpty
              ? Container()
              : InkWell(
                  onTap: () {
                    Get.to(
                      EditQuotationPage(
                        noQuotation: '${dataQuotation['no_quotation']}',
                        kutipanSewa: '${dataQuotation['kutipan_sewa']}',
                        namaCustomer: '${dataQuotation['nama_customer']}',
                        email: '${dataQuotation['email']}',
                        namaCompanyCustomer:
                            '${dataQuotation['nama_perusahaan']}',
                        kotaCustomer: '${dataQuotation['kota']}',
                        alamatCustomer: '${dataQuotation['nama_jalan']}',
                        kodePos: '${dataQuotation['kode_pos']}',
                        tanggal: '${dataQuotation['tanggal']}',
                        noHp: '${dataQuotation['no_hp']}',
                        komentar: '${dataQuotation['komentar']}',
                        idUserTtd: int.parse('${dataQuotation['id_user']}'),
                        idCustomer: int.parse('${dataQuotation['id']}'),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      decoration: BoxDecoration(
                          color: const Color(0xFF5FC4F0),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          "Edit\nQuotation",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
        ],
        foregroundColor: const Color(0xFF686868),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
      ),
      bottomNavigationBar: Container(
        height: cekTrans.isEmpty ? 65 : 108,
        width: double.infinity,
        decoration: const BoxDecoration(
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
                    overlayColor:
                        MaterialStateProperty.all(const Color(0xFF3EA8D6)),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF5DC3EF)),
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
                          width: 150,
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
                            child: const Text('Generate Quotation',
                                style: TextStyle(fontSize: 12)),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(1),
                              overlayColor: MaterialStateProperty.all(
                                  const Color(0xFFC34E4E)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFED6C6C)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 150,
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
                                // print invoice pdf
                                if (invoce.isNotEmpty) {
                                  _togglePopupVisibility(
                                    dataCompany['logo'],
                                    dataCompany['alamat'],
                                    dataCompany['kota'],
                                    dataCompany['no_hp'],
                                    dataCompany['email'],
                                    dataCompany['nama_company'],
                                    //
                                    invoce[0]['nomor_invoice'],
                                    invoce[0]['tanggal_invoice'],
                                    invoce[0]['img_tanda_tangan'],
                                    invoce[0]['tanda_penerima_pembayaran'],
                                    invoce[0]['keterangan'],
                                    invoce[0]['periode_pembayaran'],
                                    invoce[0]['metode_pembayaran'],
                                    invoce[0]['nama_bank'] == null
                                        ? 'null'
                                        : invoce[0]['nama_bank'],
                                    invoce[0]['no_rekening'] == null
                                        ? 'null'
                                        : invoce[0]['no_rekening'],
                                    invoce[0]['a_n_rekening'] == null
                                        ? 'null'
                                        : invoce[0]['a_n_rekening'],
                                    invoce[0]['nama_tanda_tangan'],
                                    subTotalRp,
                                  );
                                } else {
                                  Get.to(addDataInvoice(
                                    alamat_company: dataCompany['alamat'],
                                    kota_company: dataCompany['kota'],
                                    noHp_company: dataCompany['no_hp'],
                                    email_company: dataCompany['email'],
                                    nama_company: dataCompany['email'],
                                    id_customer: widget.id_customer,
                                    exportedImage: null,
                                  ));
                                }
                              }
                            },
                            child: Text(
                                invoce.isNotEmpty
                                    ? 'Generate Invoice'
                                    : 'Tambah Invoice',
                                style: TextStyle(fontSize: 12)),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(1),
                              overlayColor: MaterialStateProperty.all(
                                  const Color(0xFFC34E4E)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFED6C6C)),
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
                              : isLoadingDelete
                                  ? Center(
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        child: Lottie.asset(
                                            'assets/lottie/loading.json'),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: cekTrans.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return IgnorePointer(
                                          ignoring:
                                              invoce.isNotEmpty ? true : false,
                                          child: Dismissible(
                                            movementDuration: Duration.zero,
                                            key: Key(cekTrans[index]['id']
                                                .toString()),
                                            direction:
                                                DismissDirection.endToStart,
                                            confirmDismiss: (direction) async {
                                              return await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Hapus Transportasi'),
                                                    content: Text(
                                                        'Apakah Anda ingin menghapus ${cekTrans[index]['tipe_mobil']}?'),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text(
                                                            'Cancel'),
                                                        onPressed: () {
                                                          Navigator.of(context).pop(
                                                              false); // Return false to cancel dismissal
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text(
                                                            'Delete'),
                                                        onPressed: () {
                                                          Navigator.of(context).pop(
                                                              true); // Return true to proceed with dismissal
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            onDismissed: invoce.isNotEmpty
                                                ? null
                                                : (direction) {
                                                    deleteTransportation(
                                                        cekTrans[index]['id']);
                                                    setState(() {
                                                      cekTrans.removeAt(index);
                                                    });
                                                  },
                                            background: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              child: Icon(Icons.delete,
                                                  color: Colors.white),
                                              alignment: Alignment.centerRight,
                                              padding: const EdgeInsets.only(
                                                  right: 16),
                                            ),
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                Container(
                                                  width: double.infinity,
                                                  height: 128,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFFB6B6B6)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    // color:
                                                    //     const Color(0xFFFFFFFF),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          7),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          7)),
                                                          color:
                                                              Color(0xFFC3EDFF),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 5),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          200,
                                                                      // color: Colors
                                                                      //     .amber,
                                                                      child:
                                                                          Text(
                                                                        '${cekTrans[index]['tipe_mobil']}'
                                                                            .toUpperCase(),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                    invoce.isNotEmpty
                                                                        ? Container()
                                                                        : SizedBox(
                                                                            height:
                                                                                21,
                                                                            child:
                                                                                ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                primary: const Color(0xFF5FC4F0),
                                                                                elevation: 0, // Remove elevation
                                                                              ),
                                                                              onPressed: () {
                                                                                Get.to(
                                                                                  EditTransportation(
                                                                                    idTransportation: int.parse('${cekTrans[index]['id']}'),
                                                                                    id_customer: int.parse('${dataQuotation['id']}'),
                                                                                    tipeKendaraan: '${cekTrans[index]['tipe_mobil']}',
                                                                                    lamaPenggunaan: '${cekTrans[index]['lama_penggunaan']}',
                                                                                    jmlUnit: '${cekTrans[index]['jumlah']}',
                                                                                    tanggalPenggunaan: '${cekTrans[index]['tanggal_penggunaan']}',
                                                                                    harga: '${cekTrans[index]['harga']}',
                                                                                    tujuanKendaraan: '${cekTrans[index]['tujuan']}',
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: Text(
                                                                                'Edit Transportasi',
                                                                                style: TextStyle(fontSize: 11),
                                                                              ),
                                                                            ),
                                                                          )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height: 1,
                                                        color: const Color(
                                                            0xFFB6B6B6),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
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
                                                                const Text(
                                                                  "Tanggal Penggunaan",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF616161),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${cekTrans[index]['tanggal_penggunaan']}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFF616161),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 3),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "Lama Penggunaan",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF616161),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  cekTrans[
                                                                          index]
                                                                      [
                                                                      'lama_penggunaan'],
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFF616161),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 3),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "Jumlah",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF616161),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "${cekTrans[index]['jumlah']} Unit",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFF616161),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 1,
                                                              color: const Color(
                                                                  0xFFB6B6B6),
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(""),
                                                                Text(
                                                                  "Rp ${currencyFormatter.format(double.parse(cekTrans[index]['harga']))}",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFF616161),
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
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
                                            ),
                                          ),
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
