import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:transportation_rent_mobile/controllers/qutationController.dart';
import 'package:transportation_rent_mobile/utils/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:transportation_rent_mobile/widget/snackbarWidget.dart';

class QuotationPage extends StatefulWidget {
  const QuotationPage({super.key});

  @override
  State<QuotationPage> createState() => _QuotationPageState();
}

class _QuotationPageState extends State<QuotationPage> {
  DateTime dtNow = DateTime.now();
  DateTime dateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  List<String> ttd_user = [
    "M.Fadil Adim",
  ];
  // declarate input
  var nomorKutipanC = TextEditingController(text: '');
  var kutipanPenyewaanC = TextEditingController(text: '');
  var namaCustomerC = TextEditingController(text: '');
  var emailC = TextEditingController(text: '');
  var namaPerusahaanC = TextEditingController(text: '');
  var kotaC = TextEditingController(text: '');
  var alamatC = TextEditingController(text: '');
  var kodePosC = TextEditingController(text: '');
  var tanggalC = null;
  var noHpC = TextEditingController(text: '');
  var komentarC = TextEditingController(text: '');
  int? value_ttd;

  @override
  void initState() {
    super.initState();
    getDataSignature();
  }

  var isLoading = false;
  List<dynamic> result = [];
  void getDataSignature() async {
    setState(() {
      isLoading = true;
    });
    String url = '$baseUrl/user';
    // response
    try {
      var response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['message'];
        // print(data);
        setState(() {
          result = data;
        });
      } else {
        print("Get data UserSignature gagal");
      }
    } catch (e) {
      print(e);
      // SnackbarWidget().snackbarError(
      //     "Server Ada kendala atau mati, silahkan hubungi pihak pengembang");
    }

    // loding off
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Buat Quotation",
          style: TextStyle(fontSize: 18),
        ),
        foregroundColor: Color(0xFF686868),
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
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: ListView(
                children: [
                  // Nomor Kutipan
                  const Text(
                    "Nomor Kutipan",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFF616161)),
                      cursorColor: const Color(0xFF737373),
                      decoration: const InputDecoration(
                        hintText: 'Contoh. 102301001',
                        hintStyle:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                      ),
                      autocorrect: false,
                      maxLines: 1,
                      controller: nomorKutipanC,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(9),
                      ],
                    ),
                  ),

                  // Kutipan
                  const SizedBox(height: 15),
                  const Text(
                    "Kutipan Sewa",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFF616161)),
                      cursorColor: const Color(0xFF737373),
                      decoration: const InputDecoration(
                        hintText: 'Contoh. Sewa Transportasi',
                        hintStyle:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                      ),
                      autocorrect: false,
                      maxLines: 1,
                      controller: kutipanPenyewaanC,
                      textInputAction: TextInputAction.next,
                    ),
                  ),

                  // Nama Customer
                  const SizedBox(height: 15),
                  const Text(
                    "Nama Customer",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFF616161)),
                      cursorColor: const Color(0xFF737373),
                      decoration: const InputDecoration(
                        hintText: 'Contoh Ibu Selen',
                        hintStyle:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                      ),
                      autocorrect: false,
                      maxLines: 1,
                      controller: namaCustomerC,
                      textInputAction: TextInputAction.next,
                    ),
                  ),

                  // Email
                  const SizedBox(height: 15),
                  const Text(
                    "Email Customer",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    // height: 55,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFF616161)),
                      cursorColor: const Color(0xFF737373),
                      decoration: const InputDecoration(
                        hintText: 'Contoh ibu.selen@gmail.com',
                        hintStyle:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                      ),
                      autocorrect: false,
                      maxLines: 1,
                      controller: emailC,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                  ),

                  // Nama Perusahaan
                  const SizedBox(height: 15),
                  const Text(
                    "Nama Perusahaan Customer",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFF616161)),
                      cursorColor: const Color(0xFF737373),
                      decoration: const InputDecoration(
                        hintText: 'Contoh PT Tanah Jaya',
                        hintStyle:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                      ),
                      autocorrect: false,
                      maxLines: 1,
                      controller: namaPerusahaanC,
                      textInputAction: TextInputAction.next,
                    ),
                  ),

                  // Kota
                  const SizedBox(height: 15),
                  const Text(
                    "Kota Customer",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFF616161)),
                      cursorColor: const Color(0xFF737373),
                      decoration: const InputDecoration(
                        hintText: 'Contoh Surabaya',
                        hintStyle:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                      ),
                      autocorrect: false,
                      maxLines: 1,
                      controller: kotaC,
                      textInputAction: TextInputAction.next,
                    ),
                  ),

                  // Alamat Customer
                  const SizedBox(height: 15),
                  const Text(
                    "Detail Alamat Customer",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFF616161)),
                      cursorColor: const Color(0xFF737373),
                      decoration: const InputDecoration(
                        hintText: 'Contoh Jln. Surabaya kota No.10',
                        hintStyle:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                      ),
                      autocorrect: false,
                      maxLines: 1,
                      controller: alamatC,
                      textInputAction: TextInputAction.next,
                    ),
                  ),

                  // Kode pos dan tanggal
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 80,
                    // color: Colors.amber,
                    child: GridView.count(
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Kode Pos",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: TextField(
                                  style:
                                      const TextStyle(color: Color(0xFF616161)),
                                  cursorColor: const Color(0xFF737373),
                                  decoration: const InputDecoration(
                                    hintText: 'Contoh 681234',
                                    hintStyle: TextStyle(
                                        color: Color(0xFF8F8F8F), fontSize: 13),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                          width: 1, color: Color(0xFF515151)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                          width: 1, color: Color(0xFFE4E4E4)),
                                    ),
                                  ),
                                  autocorrect: false,
                                  maxLines: 1,
                                  controller: kodePosC,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tanggal",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              InkWell(
                                onTap: () async {
                                  final date = await pickerDate();
                                  if (date == null) return;
                                  final newDateTime = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                  );
                                  setState(() {
                                    dateTime = date;
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFFE4E4E4),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4))),
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "${dateTime.year}-${dateTime.month}-${dateTime.day}",
                                          style: const TextStyle(
                                              color: Color(0xFF515151),
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // Nomor Hp
                  const SizedBox(height: 7),
                  const Text(
                    "Nomor Hp Customer",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFF616161)),
                      cursorColor: const Color(0xFF737373),
                      decoration: const InputDecoration(
                        prefixStyle:
                            TextStyle(fontSize: 14, color: Colors.black),
                        prefixText: "+62  ",
                        hintText: '[031] 870 4740',
                        hintStyle:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                      ),
                      autocorrect: false,
                      maxLines: 1,
                      controller: noHpC,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                  ),

                  // Komentar
                  const SizedBox(height: 15),
                  const Text(
                    "Komentar atau Intruksi kusus",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFF616161)),
                      cursorColor: const Color(0xFF737373),
                      decoration: const InputDecoration(
                        prefixStyle:
                            TextStyle(fontSize: 14, color: Colors.black),
                        hintText: 'Boleh kosong',
                        hintStyle:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                      ),
                      autocorrect: false,
                      maxLines: 1,
                      controller: komentarC,
                      textInputAction: TextInputAction.next,
                    ),
                  ),

                  // Tanda tangan
                  const SizedBox(height: 15),
                  const Text(
                    "Tanda tangan",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 53,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF515151)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: value_ttd,
                      hint: const Text(
                        "Pilih yang bertanda tangan",
                        style:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 12),
                      ),
                      onChanged: ((value) {
                        setState(() {
                          value_ttd = value as int;
                        });
                      }),
                      items: result.map((item) {
                        return DropdownMenuItem(
                          child: Text(
                            item['nama_lengkap'],
                            style: const TextStyle(
                                color: Color(0xFF8F8F8F), fontSize: 13),
                          ),
                          value: item['id'],
                        );
                      }).toList(),
                    ),
                  ),

                  // Buttom
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        final connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.none) {
                          print("NO INTERNET");
                        } else {
                          // Get.to(DataTransportationPage(id_customer: 4));
                          if (value_ttd != null) {
                            QuotationController().postQuotation(
                              kutipanPenyewaanC.text,
                              namaCustomerC.text,
                              emailC.text,
                              namaPerusahaanC.text,
                              kotaC.text,
                              alamatC.text,
                              kodePosC.text,
                              '${dateTime.year}-${dateTime.month}-${dateTime.day}',
                              nomorKutipanC.text,
                              '${noHpC.text}',
                              komentarC.text,
                              '',
                              value_ttd!,
                            );
                          } else {
                            SnackbarWidget()
                                .snackbarError("Tanda tangan Wajib di pilih");
                          }
                        }
                      },
                      child: const Text('Simpan'),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(1),
                        overlayColor: MaterialStateProperty.all(Colors.green),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF3FC633)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Future<DateTime?> pickerDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now().subtract(const Duration(days: 14)),
        lastDate: DateTime(2100),
      );
}
