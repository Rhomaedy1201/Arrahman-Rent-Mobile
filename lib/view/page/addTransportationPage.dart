import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:transportation_rent_mobile/controllers/transportationController.dart';
import 'package:transportation_rent_mobile/formatter/thousandsSeparatorInputFormatter.dart';

class AddTransportationPage extends StatefulWidget {
  int id_customer;
  AddTransportationPage({super.key, required this.id_customer});

  @override
  State<AddTransportationPage> createState() => _AddTransportationPageState();
}

class _AddTransportationPageState extends State<AddTransportationPage> {
  DateTime dateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  // editing controller
  var tipeKendaraan = TextEditingController(text: '');
  var lama_penggunaan = TextEditingController(text: '');
  var jumlah_unit = TextEditingController(text: '');
  // var harga = TextEditingController(text: '');
  var hargaC = TextEditingController(text: '');
  var tujuan_kendaraan = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    print(widget.id_customer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Transportasi",
          style: TextStyle(fontSize: 18),
        ),
        foregroundColor: Color(0xFF686868),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: ListView(
          children: [
            Text(
              "Tipe Kendaraan",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextField(
                style: TextStyle(color: Color(0xFF616161)),
                cursorColor: Color(0xFF737373),
                decoration: InputDecoration(
                  hintText: 'Contoh. Alphard',
                  hintStyle: TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Color(0xFF515151)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                  ),
                ),
                autocorrect: false,
                maxLines: 1,
                controller: tipeKendaraan,
              ),
            ),

            // Lama penggunaan & jumlah
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              height: 80,
              // color: Colors.amber,
              child: GridView.count(
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                children: <Widget>[
                  // Lama Penggunaan
                  Container(
                    width: double.infinity,
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lama Penggunaan",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextField(
                            style: TextStyle(color: Color(0xFF616161)),
                            cursorColor: Color(0xFF737373),
                            decoration: InputDecoration(
                              hintText: 'Contoh 24',
                              suffixText: "Jam",
                              suffixStyle: TextStyle(color: Color(0xFF515151)),
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
                            controller: lama_penggunaan,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Jumlah Unit
                  Container(
                    width: double.infinity,
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jumlah Unit",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextField(
                            style: TextStyle(color: Color(0xFF616161)),
                            cursorColor: Color(0xFF737373),
                            decoration: InputDecoration(
                              hintText: 'Contoh. 1',
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
                            controller: jumlah_unit,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Lama penggunaan & jumlah
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              height: 80,
              // color: Colors.amber,
              child: GridView.count(
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                children: <Widget>[
                  // Tanggal Digunakan
                  Container(
                    width: double.infinity,
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tanggal digunakan",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5),
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
                                  color: Color(0xFFE4E4E4),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
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
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Harga
                  Container(
                    width: double.infinity,
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Harga",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
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
                              prefixText: "Rp. ",
                              prefixStyle: TextStyle(color: Color(0xFF515151)),
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
                            controller: hargaC,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tujuan Kendaraan
            const SizedBox(height: 8),
            Text(
              "Tujuan Kendaraan",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextField(
                style: TextStyle(color: Color(0xFF616161)),
                cursorColor: Color(0xFF737373),
                decoration: InputDecoration(
                  hintText: 'Contoh. Luar Kota',
                  hintStyle: TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Color(0xFF515151)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                  ),
                ),
                autocorrect: false,
                maxLines: 1,
                controller: tujuan_kendaraan,
              ),
            ),

            // Button
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  // cek internet connection
                  final connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.none) {
                    print("NO INTERNET");
                  } else {
                    TransportationController().postTransportation(
                      widget.id_customer,
                      tipeKendaraan.text,
                      "${lama_penggunaan.text} jam",
                      jumlah_unit.text,
                      "${dateTime.year}-${dateTime.month}-${dateTime.day}",
                      '${hargaC.text.replaceAll(RegExp('[^A-Za-z0-9]'), '')}',
                      tujuan_kendaraan.text,
                    );
                  }
                },
                child: const Text(
                  'Tambah Transportasi',
                  style: TextStyle(fontSize: 12),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(1),
                  overlayColor: MaterialStateProperty.all(Color(0xFF3EA8D6)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF5DC3EF)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> pickerDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
}
