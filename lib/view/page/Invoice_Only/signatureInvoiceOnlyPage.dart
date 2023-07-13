import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:transportation_rent_mobile/controllers/editInvoiceOnlyController.dart';
import 'package:transportation_rent_mobile/controllers/signatureInvoiceOnlyController.dart';
import 'package:transportation_rent_mobile/widget/snackbarWidget.dart';

class SignatureInvoiceOnlyPage extends StatefulWidget {
  String nomorInvoiceC,
      tanggal_invoiceC,
      tandaPenerimaC,
      keteranganC,
      periodePembayaranC,
      totalPembayaranC,
      metodePembayaranC,
      namaBankC,
      no_rekeningC,
      a_n_rekening,
      namaTtd,
      fotoTtd;
  int id;

  SignatureInvoiceOnlyPage({
    super.key,
    //invoice
    required this.id,
    required this.nomorInvoiceC,
    required this.tanggal_invoiceC,
    required this.tandaPenerimaC,
    required this.keteranganC,
    required this.periodePembayaranC,
    required this.totalPembayaranC,
    required this.metodePembayaranC,
    required this.namaBankC,
    required this.no_rekeningC,
    required this.a_n_rekening,
    required this.namaTtd,
    required this.fotoTtd,
  });

  @override
  State<SignatureInvoiceOnlyPage> createState() =>
      _SignatureInvoiceOnlyPageState();
}

class _SignatureInvoiceOnlyPageState extends State<SignatureInvoiceOnlyPage> {
  Uint8List? ttd_image;

  SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  @override
  void initState() {
    super.initState();
    debugPrint(widget.nomorInvoiceC);
    debugPrint(widget.tanggal_invoiceC);
    debugPrint(widget.tandaPenerimaC);
    debugPrint(widget.periodePembayaranC);
    debugPrint(widget.totalPembayaranC);
    debugPrint(widget.metodePembayaranC);
    debugPrint(widget.namaBankC);
    debugPrint(widget.no_rekeningC);
    debugPrint(widget.a_n_rekening);
    setNameFromEdit();
  }

  void setNameFromEdit() {
    if (mounted)
      setState(() {
        nama_tanda_tanganC.text =
            widget.namaTtd == 'null' ? '' : widget.namaTtd;
      });
  }

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
        title: Text(
          widget.namaTtd == 'null'
              ? "Buat Tanda Tangan Invoice"
              : "Edit Tanda Tangan Invoice",
          style: const TextStyle(
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
                          ttd_image = await _controller.toPngBytes();
                          if (mounted) {
                            setState(() {});
                          }
                          final connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (connectivityResult == ConnectivityResult.none) {
                            debugPrint("NO INTERNET");
                          } else {
                            if (ttd_image == null) {
                              SnackbarWidget().snackbarError(
                                  "Silahkan Tambah Tanda Tangan Terlebih dahulu");
                            } else {
                              if (widget.namaTtd == 'null') {
                                SignatureInvoiceOnlyController().addInvoceOnly(
                                  widget.nomorInvoiceC,
                                  widget.tanggal_invoiceC,
                                  widget.tandaPenerimaC == ''
                                      ? 'null'
                                      : widget.tandaPenerimaC,
                                  widget.keteranganC,
                                  widget.periodePembayaranC,
                                  '${widget.totalPembayaranC.replaceAll(',', '')}',
                                  widget.metodePembayaranC,
                                  widget.namaBankC,
                                  widget.no_rekeningC,
                                  widget.a_n_rekening,
                                  nama_tanda_tanganC.text,
                                  ttd_image!,
                                );
                              } else {
                                EditInvoiceOnlyController().editInvoceOnly(
                                  widget.id,
                                  widget.nomorInvoiceC,
                                  widget.tanggal_invoiceC,
                                  widget.tandaPenerimaC == ''
                                      ? 'null'
                                      : widget.tandaPenerimaC,
                                  widget.keteranganC,
                                  widget.periodePembayaranC,
                                  '${widget.totalPembayaranC.replaceAll(',', '')}',
                                  widget.metodePembayaranC,
                                  widget.namaBankC,
                                  widget.no_rekeningC,
                                  widget.a_n_rekening,
                                  nama_tanda_tanganC.text,
                                  widget.fotoTtd,
                                  ttd_image!,
                                );
                              }
                            }
                          }
                        },
                        child: Text(
                            widget.namaTtd == 'null' ? 'Simpan' : 'Edit',
                            style: TextStyle(fontSize: 13)),
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
