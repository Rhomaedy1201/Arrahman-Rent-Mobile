import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transportation_rent_mobile/view/history/historyInvoiceOnly.dart';
import 'package:transportation_rent_mobile/view/history/searchDataHistory.dart';
import 'package:transportation_rent_mobile/view/page/homePage.dart';

class MenuHistory extends StatelessWidget {
  const MenuHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pilih History",
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAll(const HomePage());
          },
          icon: const Icon(Icons.arrow_back),
        ),
        foregroundColor: const Color(0xFF686868),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.offAll(const SearchDataHistory());
                },
                child: const Text("History Quotation & Invoce"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.offAll(const HistoryInvoiceOnly());
                },
                child: const Text("History Invoce"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
