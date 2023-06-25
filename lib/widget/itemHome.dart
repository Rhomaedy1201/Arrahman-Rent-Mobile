import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:transportation_rent_mobile/view/history/menuHostory.dart';
import 'package:transportation_rent_mobile/view/history/searchDataHistory.dart';
import 'package:transportation_rent_mobile/view/page/Invoice_Only/addDataInvoiceOnly.dart';
import 'package:transportation_rent_mobile/view/page/profileCompanyPage.dart';
import 'package:transportation_rent_mobile/view/page/Quotation/quotationPage.dart';
import 'package:transportation_rent_mobile/view/page/signaturePage.dart';

class ItemHome {
  Widget createSignature(bool isMobile) {
    return InkWell(
      onTap: () async {
        final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          debugPrint("NO INTERNET");
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
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: isMobile ? 65 : 100,
                height: isMobile ? 65 : 100,
                child: Center(
                    child: Lottie.asset("assets/lottie/signature.json"))),
            const SizedBox(height: 10),
            Text(
              "Tambah\nTanda Tangan",
              textAlign: TextAlign.center,
              style: isMobile
                  ? const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    )
                  : const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    ),
            )
          ],
        ),
      ),
    );
  }

  //  createSignature
  Widget createQuotation(bool isMobile) {
    return InkWell(
      onTap: () async {
        final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          print("NO INTERNET");
        } else {
          Get.to(const QuotationPage());
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
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: isMobile ? 75 : 100,
              height: isMobile ? 75 : 100,
              // color: Color(0xFF777777),
              child: SizedBox(
                child: Lottie.asset("assets/lottie/kutipan.json"),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Buat\nQuotation",
              textAlign: TextAlign.center,
              style: isMobile
                  ? const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    )
                  : const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    ),
            )
          ],
        ),
      ),
    );
  }

  //  createSignature
  Widget createInvoiceOnly(bool isMobile) {
    return InkWell(
      onTap: () async {
        final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          print("NO INTERNET");
        } else {
          Get.to(AddDataInvoiceOnly(
            idInvoiceOnly: 0,
          ));
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
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: isMobile ? 65 : 100,
              height: isMobile ? 65 : 100,
              // color: Color(0xFF777777),
              child: SizedBox(
                child: Lottie.asset("assets/lottie/buat-invoice.json"),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Buat\nInvoice",
              textAlign: TextAlign.center,
              style: isMobile
                  ? const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    )
                  : const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget searchDataQuotation(bool isMobile) {
    return InkWell(
      onTap: () async {
        final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          debugPrint("NO INTERNET");
        } else {
          Get.to(const MenuHistory());
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
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: isMobile ? 75 : 100,
              height: isMobile ? 75 : 100,
              // color: Color(0xFF777777),
              child: SizedBox(
                child: Lottie.asset("assets/lottie/history.json"),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "History\nData",
              textAlign: TextAlign.center,
              style: isMobile
                  ? const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    )
                  : const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget changeCompany(bool isMobile) {
    return InkWell(
      onTap: () async {
        final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          debugPrint("NO INTERNET");
        } else {
          Get.to(ProfileCompanyPage());
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
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: isMobile ? 65 : 100,
              height: isMobile ? 65 : 100,
              // color: Color(0xFF777777),
              child: SizedBox(
                child: Lottie.asset("assets/lottie/profile-perusahaan.json"),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Profil\nPerusahaan",
              textAlign: TextAlign.center,
              style: isMobile
                  ? const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    )
                  : const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF707070),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
