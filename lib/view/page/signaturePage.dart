import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:transportation_rent_mobile/controllers/signatureUserController.dart';
import 'package:transportation_rent_mobile/widget/materialDialogWidget.dart';

class SignaturePage extends StatefulWidget {
  SignaturePage({super.key});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  Uint8List? exportedImage;
  TextEditingController namaLengkapC = TextEditingController(text: '');

  SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3AA9D9),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextField(
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Masukkan Nama Lengkap',
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
                    controller: namaLengkapC,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                  ),
                  child: Signature(
                    width: double.infinity,
                    height: 450,
                    controller: _controller,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        MaterialDialogWidget.signatureDialog(context);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Batal",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 52,
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
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xFFDFE8EC)),
                                  ),
                                )),
                          ),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () async {
                              final connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                  ConnectivityResult.none) {
                                print("NO INTERNET");
                              } else {
                                exportedImage = await _controller.toPngBytes();
                                List<int> byte = (exportedImage == null)
                                    ? []
                                    : exportedImage!;
                                SignatureUserController()
                                    .addSignatureUser(namaLengkapC.text, byte);
                                setState(() {});
                              }
                            },
                            child: Text('Simpan'),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(1),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.green),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF3FC633)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
