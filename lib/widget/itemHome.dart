import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:transportation_rent_mobile/view/history/searchDataHistory.dart';
import 'package:transportation_rent_mobile/view/page/quotationPage.dart';
import 'package:transportation_rent_mobile/view/page/signaturePage.dart';

class ItemHome extends StatelessWidget {
  late bool isMobile;
  ItemHome({super.key, required this.isMobile});

  Widget createSignature = InkWell(
    onTap: () async {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        print("NO INTERNET");
      } else {
        Get.to(SignaturePage());
      }
    },
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFFFCFCFC),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFDCDCDC),
            blurRadius: 4,
            offset: Offset(2, 2), // Shadow position
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 65,
              height: 65,
              child:
                  Center(child: Lottie.asset("assets/lottie/signature.json"))),
          SizedBox(height: 10),
          Text(
            "Tambah\nTanda Tangan",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF707070),
            ),
          )
        ],
      ),
    ),
  );

  final createQuotation = InkWell(
    onTap: () async {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        print("NO INTERNET");
      } else {
        Get.to(QuotationPage());
      }
    },
    child: Container(
      width: 90,
      height: 90,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFFFCFCFC),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFDCDCDC),
            blurRadius: 4,
            offset: Offset(2, 2), // Shadow position
          ),
        ],
      ),
      padding: EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 75,
            height: 75,
            // color: Color(0xFF777777),
            child: SizedBox(
              child: Lottie.asset("assets/lottie/kutipan.json"),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Buat\nKutipan",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF707070),
            ),
          )
        ],
      ),
    ),
  );

  final searchDataQuotation = InkWell(
    onTap: () async {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        print("NO INTERNET");
      } else {
        Get.offAll(SearchDataHistory());
      }
    },
    child: Container(
      width: 90,
      height: 90,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFFFCFCFC),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFDCDCDC),
            blurRadius: 4,
            offset: Offset(2, 2), // Shadow position
          ),
        ],
      ),
      padding: EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 75,
            height: 75,
            // color: Color(0xFF777777),
            child: SizedBox(
              child: Lottie.asset("assets/lottie/history.json"),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "History\nData Quotation",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF707070),
            ),
          )
        ],
      ),
    ),
  );

  final changeCompany = InkWell(
    onTap: () async {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        print("NO INTERNET");
      } else {
        Get.to(QuotationPage());
      }
    },
    child: Container(
      width: 90,
      height: 90,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFFFCFCFC),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFDCDCDC),
            blurRadius: 4,
            offset: Offset(2, 2), // Shadow position
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 65,
            height: 65,
            // color: Color(0xFF777777),
            child: SizedBox(
              child: Lottie.asset("assets/lottie/profile-perusahaan.json"),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Profil\nPerusahaan",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF707070),
            ),
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
