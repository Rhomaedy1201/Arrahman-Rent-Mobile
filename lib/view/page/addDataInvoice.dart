import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transportation_rent_mobile/view/page/signatureInvocePage.dart';
import 'package:transportation_rent_mobile/widget/snackbarWidget.dart';

class addDataInvoice extends StatefulWidget {
  String alamat_company,
      kota_company,
      noHp_company,
      email_company,
      nama_company;
  int id_customer;
  Uint8List? exportedImage;
  addDataInvoice({
    super.key,
    required this.alamat_company,
    required this.kota_company,
    required this.noHp_company,
    required this.email_company,
    required this.nama_company,
    required this.id_customer,
    required this.exportedImage,
  });

  @override
  State<addDataInvoice> createState() => _addDataInvoiceState();
}

class _addDataInvoiceState extends State<addDataInvoice> {
  var penerimaC = TextEditingController(text: '');
  var keteranganC = TextEditingController(text: '');
  var periodePembayaranC = TextEditingController(text: '');
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
          "Tambah Invoice",
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
                // Tanda Terima Pembayaran
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
                      hintText: 'Tanda Penerima Pembayaran',
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
                              style: const TextStyle(color: Color(0xFF616161)),
                              cursorColor: const Color(0xFF737373),
                              decoration: const InputDecoration(
                                hintText: 'Contoh. BCA',
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
                                hintText: 'Contoh. 0234567891',
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
                              textInputAction: TextInputAction.next,
                            ),
                          ),

                          // Nama Bank
                          const SizedBox(height: 15),
                          const Text(
                            "A.N Rekening",
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
                    onPressed: () {
                      // Get.off(DataTransportationPage(
                      //     id_customer: widget.id_customer));
                      // SignatureInvoceController().addInvoce(
                      //   '${widget.id_customer}',
                      //   penerimaC.text,
                      //   keteranganC.text,
                      //   periodePembayaranC.text,
                      //   valuePembayaran!,
                      //   namaBankC.text,
                      //   noRekeningC.text,
                      //   namaRekeningC.text,
                      //   "Tess",
                      //   widget.exportedImage!,
                      // );
                      if (penerimaC.text == '' ||
                          keteranganC.text == '' ||
                          periodePembayaranC.text == '' ||
                          valuePembayaran == null ||
                          namaBankC.text == '' ||
                          noRekeningC.text == '' ||
                          namaRekeningC.text == '') {
                        SnackbarWidget()
                            .snackbarError("Data Tidak boleh kosong");
                      } else {
                        Get.to(SignatureInvocePage());
                      }
                    },
                    child: Text('Selajutnya', style: TextStyle(fontSize: 13)),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(1),
                      overlayColor:
                          MaterialStateProperty.all(const Color(0xFFC34E4E)),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFED6C6C)),
                    ),
                  ),
                ),
                // const SizedBox(height: 10),
                // SizedBox(
                //   width: double.infinity,
                //   height: 45,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       InvoicePdf().printPdf(
                //         widget.alamat_company,
                //         widget.kota_company,
                //         widget.noHp_company,
                //         widget.email_company,
                //         widget.nama_company,
                //         widget.id_customer,
                //         widget.exportedImage,
                //         //
                //         penerimaC.text,
                //         keteranganC.text,
                //         periodePembayaranC.text,
                //         valuePembayaran.toString(),
                //         namaBankC.text,
                //         noRekeningC.text,
                //         namaRekeningC.text,
                //       );
                //     },
                //     child:
                //         Text('Print Invoice', style: TextStyle(fontSize: 13)),
                //     style: ButtonStyle(
                //       elevation: MaterialStateProperty.all<double>(1),
                //       overlayColor:
                //           MaterialStateProperty.all(const Color(0xFFC34E4E)),
                //       backgroundColor:
                //           MaterialStateProperty.all(const Color(0xFFED6C6C)),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 10),
                // SizedBox(
                //   width: double.infinity,
                //   height: 45,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Get.to(
                //         SignatureInvocePage(
                //           alamat_company: widget.alamat_company,
                //           kota_company: widget.kota_company,
                //           noHp_company: widget.noHp_company,
                //           email_company: widget.email_company,
                //           nama_company: widget.nama_company,
                //           id_customer: widget.id_customer,
                //           exportedImage: widget.exportedImage == null
                //               ? null
                //               : widget.exportedImage,
                //         ),
                //       );
                //     },
                //     child: Text(
                //       'Tambah Tanda Tangan',
                //       style: TextStyle(fontSize: 13),
                //     ),
                //     style: ButtonStyle(
                //       elevation: MaterialStateProperty.all<double>(1),
                //       overlayColor:
                //           MaterialStateProperty.all(const Color(0xFFC34E4E)),
                //       backgroundColor:
                //           MaterialStateProperty.all(const Color(0xFFED6C6C)),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
