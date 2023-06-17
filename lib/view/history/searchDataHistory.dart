import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:transportation_rent_mobile/utils/base_url.dart';
import 'package:transportation_rent_mobile/view/page/dataTransportasionPage.dart';
import 'package:transportation_rent_mobile/widget/snackbarWidget.dart';

class SearchDataHistory extends StatefulWidget {
  const SearchDataHistory({super.key});

  @override
  State<SearchDataHistory> createState() => _SearchDataHistoryState();
}

class _SearchDataHistoryState extends State<SearchDataHistory> {
  var search = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    getCustomer();
  }

  // Get data Quotation
  var isLoading = false;
  List<dynamic> dataCustomer = [];
  List<dynamic> filteredList = [];

  void getCustomer() async {
    setState(() {
      isLoading = true;
    });
    String url = "$baseUrl/customer";

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataCustomer = json.decode(response.body)['data'];
        filteredList = dataCustomer;
        // print(dataCustomer);
      } else {
        print(response.body);
      }
    } catch (e) {
      // SnackbarWidget().snackbarError(
      //     "Server Ada kendala atau mati, silahkan hubungi pihak pengembang");
      print(e);
    }
    // print(dataCustomer['id']);
    setState(() {
      isLoading = false;
    });
  }

  void _filterData(String query) {
    setState(() {
      filteredList = dataCustomer
          .where((item) =>
              item['nama_customer'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      print(filteredList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(fontSize: 18),
        ),
        foregroundColor: Color(0xFF686868),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
      ),
      body: isLoading
          ? Center(
              child: Text("Loading..."),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      onChanged: _filterData,
                      style: const TextStyle(color: Color(0xFF616161)),
                      cursorColor: Color(0xFF737373),
                      decoration: const InputDecoration(
                        prefixStyle:
                            TextStyle(fontSize: 14, color: Colors.black),
                        hintText: 'contoh. Ibu Murni',
                        labelText: "Cari Customer",
                        labelStyle: TextStyle(fontSize: 13),
                        suffixIcon: Icon(Icons.search),
                        hintStyle:
                            TextStyle(color: Color(0xFF8F8F8F), fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF5DC3EF)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFFE4E4E4)),
                        ),
                      ),
                      autocorrect: false,
                      maxLines: 1,
                      controller: search,
                      textInputAction: TextInputAction.search,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "History List",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ListView.builder(
                    itemCount: filteredList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return InkWell(
                        splashColor: Color(0xFF7EECFF),
                        onTap: () async {
                          // ceck Interner Connection
                          final connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (connectivityResult == ConnectivityResult.none) {
                            print("NO INTERNET");
                          } else {
                            // to Data Transportation
                            Get.to(DataTransportationPage(
                                id_customer: item['id']));
                            search.text = '';
                            getCustomer();
                          }
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFA3E2FD),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFDBDBDB),
                                      blurRadius: 2,
                                      offset: Offset(1, 2), // Shadow position
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item['nama_customer'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF353535),
                                            ),
                                          ),
                                          Text(
                                            item['tanggal'],
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF5E5E5E),
                                            ),
                                          ),
                                          // Container(
                                          //   width: 15,
                                          //   height: 65,
                                          //   decoration: const BoxDecoration(
                                          //     color: Color(0xFF00A7EF),
                                          //     borderRadius: BorderRadius.only(
                                          //       topLeft: Radius.circular(7),
                                          //       bottomLeft: Radius.circular(2),
                                          //       bottomRight: Radius.circular(20),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${item['nama_perusahaan']}, ${item['kota']}',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF5E5E5E),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Tanda Tangan",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF5E5E5E),
                                            ),
                                          ),
                                          Text(
                                            item['nama_lengkap'],
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF5E5E5E),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }
}
