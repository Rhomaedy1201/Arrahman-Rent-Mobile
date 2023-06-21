import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:transportation_rent_mobile/providers/quotationProvider.dart';
import 'package:transportation_rent_mobile/utils/base_url.dart';
import 'package:transportation_rent_mobile/view/page/dataTransportasionPage.dart';
import 'package:transportation_rent_mobile/widget/snackbarWidget.dart';

class QuotationController extends GetxController {
  void postQuotation(
    String kutipan_sewa,
    String nama_cus,
    String email,
    String nama_perusahaan,
    String kota,
    String detail_alamat,
    String pos,
    String tanggal,
    String no_quotation,
    String no_hp,
    String komentar,
    String total_harga,
    int id_user_ttd,
  ) {
    try {
      QuotationProvider()
          .postQuotation(
        kutipan_sewa,
        nama_cus,
        email,
        nama_perusahaan,
        kota,
        detail_alamat,
        pos,
        tanggal,
        no_quotation,
        no_hp,
        komentar,
        total_harga,
        id_user_ttd,
      )
          .then((response) {
        if (response.statusCode == 200) {
          SnackbarWidget().snackbarSuccess(response.body['message']);
          var getIdCus = response.body['data'];
          Get.offAll(DataTransportationPage(
            id_customer: getIdCus['id'],
            isBack: 'false',
          ));
        } else {
          SnackbarWidget().snackbarError(response.body['message']);
          print(response.body);
        }
      });
    } catch (e) {
      // SnackbarWidget().snackbarError(
      //     "Server Ada kendala atau mati, silahkan hubungi pihak pengembang");
      print(e);
    }
  }

  void updateQuotation(
    int idCustomer,
    String kutipan_sewa,
    String nama_cus,
    String email,
    String nama_perusahaan,
    String kota,
    String detail_alamat,
    String pos,
    String tanggal,
    String no_quotation,
    String no_hp,
    String komentar,
    String total_harga,
    int id_user_ttd,
  ) {
    try {
      QuotationProvider()
          .updateQuotation(
        idCustomer,
        kutipan_sewa,
        nama_cus,
        email,
        nama_perusahaan,
        kota,
        detail_alamat,
        pos,
        tanggal,
        no_quotation,
        no_hp,
        komentar,
        total_harga,
        id_user_ttd,
      )
          .then((response) {
        if (response.statusCode == 200) {
          SnackbarWidget().snackbarSuccess("Berhasil Merubah Cutomer");
          var getIdCus = response.body['data'];
          Get.offAll(
              DataTransportationPage(id_customer: idCustomer, isBack: 'false'));
        } else {
          SnackbarWidget().snackbarError(response.body['message']);
          print(response.body);
        }
      });
    } catch (e) {
      // SnackbarWidget().snackbarError(
      //     "Server Ada kendala atau mati, silahkan hubungi pihak pengembang");
      print(e);
    }
  }

  Future<Map<String, dynamic>?> getTransportation(int id_customer) async {
    String url = "$baseUrl/transportation/$id_customer";
    var result;

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        result = json.decode(response.body)['data'];
        return result;
      } else {
        print(response.body);
      }
      return result;
    } catch (e) {
      // SnackbarWidget().snackbarError(
      //     "Server Ada kendala atau mati, silahkan hubungi pihak pengembang");
      print(e);
    }
  }
}
