import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transportation_rent_mobile/formatter/thousandsSeparatorInputFormatter.dart';
import 'package:transportation_rent_mobile/view/page/Invoice_Only/signatureInvoiceOnlyPage.dart';
import 'package:transportation_rent_mobile/widget/snackbarWidget.dart';

class AddDataInvoiceOnly extends StatefulWidget {
  const AddDataInvoiceOnly({super.key});

  @override
  State<AddDataInvoiceOnly> createState() => _AddDataInvoiceOnlyState();
}

class _AddDataInvoiceOnlyState extends State<AddDataInvoiceOnly> {
  DateTime dateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  var nomorInvoiceC = TextEditingController(text: '');
  var penerimaC = TextEditingController(text: '');
  var keteranganC = TextEditingController(text: '');
  var periodePembayaranC = TextEditingController(text: '');
  var totalPembayaranC = TextEditingController(text: '');
  String? valuePembayaran;
  var namaBankC = TextEditingController(text: '');
  var noRekeningC = TextEditingController(text: '');
  var namaRekeningC = TextEditingController(text: '');

  //List listPembayaran
  List pembayaranList = [
    'transfer',
    'cash',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Buat Invoice",
          style: TextStyle(fontSize: 18),
        ),
        foregroundColor: const Color(0xFF686868),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nomor Invoice dan tanggal invoice
                const SizedBox(height: 5),
                SizedBox(
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
                              "Nomor Invoice",
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
                                  hintText: 'Contoh 012112001',
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
                                controller: nomorInvoiceC,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(9),
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
                              "Tanggal Invoice dibuat",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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

                // Tanda Terima Pembayaran
                const SizedBox(height: 5),
                const Text(
                  "Tanda Terima Pembayaran",
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
                      hintText: 'Tanda Terima Pembayaran',
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
                    controller: penerimaC,
                    textInputAction: TextInputAction.next,
                  ),
                ),

                // Kerangan
                const SizedBox(height: 15),
                const Text(
                  "Keterangan",
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
                      hintText: 'Contoh. Sewa 2 unit Kendaraan Roda 4',
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
                    controller: keteranganC,
                    textInputAction: TextInputAction.next,
                  ),
                ),

                // Periode Pembayaran
                const SizedBox(height: 15),
                const Text(
                  "Periode Pembayaran",
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
                      hintText: 'Contoh. bulan Januari 2022',
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
                    controller: periodePembayaranC,
                    textInputAction: TextInputAction.next,
                  ),
                ),

                // total pembayaran
                const SizedBox(height: 15),
                Text(
                  "Total Pembayaran Tanpa PPN",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      ThousandsSeparatorInputFormatter(),
                    ],
                    style: TextStyle(color: Color(0xFF616161)),
                    cursorColor: Color(0xFF737373),
                    decoration: InputDecoration(
                      hintText: '2,000,000',
                      prefixText: "Rp ",
                      prefixStyle: TextStyle(color: Color(0xFF515151)),
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
                    controller: totalPembayaranC,
                  ),
                ),

                // Tanda tangan
                const SizedBox(height: 15),
                const Text(
                  "Metode Pembayaran",
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
                    value: valuePembayaran,
                    hint: const Text(
                      "Pilih metode pembayaran",
                      style: TextStyle(color: Color(0xFF8F8F8F), fontSize: 12),
                    ),
                    onChanged: ((value) {
                      setState(() {
                        valuePembayaran = value as String;
                        print(valuePembayaran);
                        namaBankC.text = '';
                        noRekeningC.text = '';
                        namaRekeningC.text = '';
                      });
                    }),
                    items: pembayaranList.map((item) {
                      return DropdownMenuItem(
                        child: Text(
                          "$item".toUpperCase(),
                          style: const TextStyle(
                              color: Color(0xFF8F8F8F), fontSize: 13),
                        ),
                        value: item,
                      );
                    }).toList(),
                  ),
                ),

                valuePembayaran == "cash"
                    ? const Text("")
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Bank
                          const SizedBox(height: 15),
                          const Text(
                            "Nama Bank",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextField(
                              textCapitalization: TextCapitalization.characters,
                              onChanged: (value) {
                                namaBankC.value = namaBankC.value.copyWith(
                                  text: value.toUpperCase(),
                                  selection: TextSelection.fromPosition(
                                    TextPosition(offset: value.length),
                                  ),
                                );
                              },
                              style: const TextStyle(color: Color(0xFF616161)),
                              cursorColor: const Color(0xFF737373),
                              decoration: const InputDecoration(
                                hintText: 'Contoh. BRI',
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
                              controller: namaBankC,
                              textInputAction: TextInputAction.next,
                            ),
                          ),

                          // No rekening
                          const SizedBox(height: 15),
                          const Text(
                            "No Rekening",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextField(
                              style: const TextStyle(color: Color(0xFF616161)),
                              cursorColor: const Color(0xFF737373),
                              decoration: const InputDecoration(
                                hintText: 'Contoh. 023-456-78910-2889',
                                hintStyle: TextStyle(
                                    color: Color(0xFF8F8F8F), fontSize: 13),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFF515151),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFE4E4E4),
                                  ),
                                ),
                              ),
                              autocorrect: false,
                              maxLines: 1,
                              controller: noRekeningC,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(25),
                              ],
                            ),
                          ),

                          // Nama Bank
                          const SizedBox(height: 15),
                          const Text(
                            "a.n Rekening",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextField(
                              textCapitalization: TextCapitalization.characters,
                              onChanged: (value) {
                                namaRekeningC.value =
                                    namaRekeningC.value.copyWith(
                                  text: value.toUpperCase(),
                                  selection: TextSelection.fromPosition(
                                    TextPosition(offset: value.length),
                                  ),
                                );
                              },
                              style: const TextStyle(color: Color(0xFF616161)),
                              cursorColor: const Color(0xFF737373),
                              decoration: const InputDecoration(
                                hintText: 'Contoh. Mamat Dani',
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
                              controller: namaRekeningC,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      final connectivityResult =
                          await (Connectivity().checkConnectivity());
                      if (connectivityResult == ConnectivityResult.none) {
                        debugPrint("NO INTERNET");
                      } else {
                        if (nomorInvoiceC.text == '' ||
                            keteranganC.text == '' ||
                            periodePembayaranC.text == '' ||
                            valuePembayaran == null) {
                          SnackbarWidget()
                              .snackbarError("Data Tidak boleh kosong");
                        } else {
                          Get.to(
                            SignatureInvoiceOnlyPage(
                              nomorInvoiceC: nomorInvoiceC.text,
                              tanggal_invoiceC:
                                  "${dateTime.year}-${dateTime.month}-${dateTime.day}",
                              tandaPenerimaC: penerimaC.text,
                              keteranganC: keteranganC.text,
                              periodePembayaranC: periodePembayaranC.text,
                              totalPembayaranC: totalPembayaranC.text,
                              metodePembayaranC: valuePembayaran.toString(),
                              namaBankC: namaBankC.text,
                              no_rekeningC: noRekeningC.text,
                              a_n_rekening: namaRekeningC.text,
                            ),
                          );
                        }
                      }
                    },
                    child: Text('Selanjutnya', style: TextStyle(fontSize: 13)),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(1),
                      overlayColor:
                          MaterialStateProperty.all(const Color(0xFFC34E4E)),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFED6C6C)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
