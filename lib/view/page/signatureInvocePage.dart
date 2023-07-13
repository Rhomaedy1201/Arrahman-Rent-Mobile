import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureInvocePage extends StatefulWidget {
  const SignatureInvocePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3AA9D9),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const Text(
                  "Buat Tanda Tangan Invoice",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
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
                        onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
