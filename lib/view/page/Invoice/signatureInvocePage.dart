import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:transportation_rent_mobile/controllers/signatureInvoceController.dart';
import 'package:transportation_rent_mobile/view/page/Transportation/dataTransportasionPage.dart';
import 'package:transportation_rent_mobile/widget/snackbarWidget.dart';

class SignatureInvocePage extends StatefulWidget {
  String alamat_company,
      kota_company,
      noHp_company,
      email_company,
      nama_company;
  int id_customer;
  Uint8List? exportedImage;
  String nomorInvoiceC,
      tanggal_invoiceC,
      tandaPenerimaC,
      keteranganC,
      periodePembayaranC,
      metodePembayaranC,
      namaBankC,
      no_rekeningC,
      a_n_rekening;
  //Invoce
  SignatureInvocePage({
    super.key,
    required this.alamat_company,
    required this.kota_company,
    required this.noHp_company,
    required this.email_company,
    required this.nama_company,
    required this.id_customer,
    required this.exportedImage,
    //invoice
    required this.nomorInvoiceC,
    required this.tanggal_invoiceC,
    required this.tandaPenerimaC,
    required this.keteranganC,
    required this.periodePembayaranC,
    required this.metodePembayaranC,
    required this.namaBankC,
    required this.no_rekeningC,
    required this.a_n_rekening,
  });

  @override
  State<SignatureInvocePage> createState() => _SignatureInvocePageState();
}

class _SignatureInvocePageState extends State<SignatureInvocePage> {
  Uint8List? exportedImage;

  SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  var print = false;

  var nama_tanda_tanganC = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3AA9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3AA9D9),
        elevation: 0.8,
        centerTitle: false,
        title: const Text(
          "Buat Tanda Tangan Invoice",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextField(
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Masukkan Nama Lengkap yang bertanda tangan',
                      hintStyle:
                          TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                    autocorrect: false,
                    maxLines: 1,
                    controller: nama_tanda_tanganC,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                  ),
                  child: Signature(
                    width: double.infinity,
                    height: 300,
                    controller: _controller,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          _controller.clear();
                        },
                        child: Text(
                          'Hapus',
                          style: TextStyle(color: Color(0xFFDFE8EC)),
                        ),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                side: BorderSide(color: Color(0xFFDFE8EC)),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          exportedImage = await _controller.toPngBytes();
                          setState(() {});
                          final connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (connectivityResult == ConnectivityResult.none) {
                            debugPrint("NO INTERNET");
                          } else {
                            if (exportedImage == null) {
                              SnackbarWidget().snackbarError(
                                  "Silahkan Tambah Tanda Tangan Terlebih dahulu");
                            } else {
                              SignatureInvoceController().addInvoce(
                                '${widget.id_customer}',
                                widget.nomorInvoiceC,
                                widget.tanggal_invoiceC,
                                widget.tandaPenerimaC == ''
                                    ? 'null'
                                    : widget.tandaPenerimaC,
                                widget.keteranganC,
                                widget.periodePembayaranC,
                                widget.metodePembayaranC,
                                widget.namaBankC,
                                widget.no_rekeningC,
                                widget.a_n_rekening,
                                nama_tanda_tanganC.text,
                                exportedImage!,
                              );
                              setState(() {
                                print = true;
                              });
                            }
                          }
                        },
                        child: Text('Simpan', style: TextStyle(fontSize: 13)),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(1),
                          overlayColor: MaterialStateProperty.all(Colors.green),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF3FC633)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
