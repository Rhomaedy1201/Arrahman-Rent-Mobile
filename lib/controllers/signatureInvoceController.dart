import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transportation_rent_mobile/utils/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:transportation_rent_mobile/view/page/dataTransportasionPage.dart';
import 'package:transportation_rent_mobile/view/page/homePage.dart';
import 'package:transportation_rent_mobile/widget/snackbarWidget.dart';

class SignatureInvoceController {
  Rxn<File> imageFile = Rxn<File>();
  String url = "$baseUrl/invoce/create";

  Future<void> addInvoce(
    String id_customer,
    String nomor_invoice,
    String tanggal_invoice,
    String tanda_penerima_pembayaran,
    String keterangan,
    String periode_pembayaran,
    String metode_pembayaran,
    String nama_bank,
    String no_rekening,
    String a_n_rekening,
    String nama_tanda_tangan,
    List<int> tanda_tangan,
  ) async {
    try {
      File imageFile = await _convertBytesToFile(tanda_tangan);
      // Make API post request
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id_customer'] = id_customer as String;
      request.fields['nomor_invoice'] = nomor_invoice;
      request.fields['tanggal_invoice'] = tanggal_invoice;
      request.fields['tanda_penerima_pembayaran'] = tanda_penerima_pembayaran;
      request.fields['keterangan'] = keterangan;
      request.fields['periode_pembayaran'] = periode_pembayaran;
      request.fields['metode_pembayaran'] = metode_pembayaran;
      request.fields['nama_bank'] = nama_bank;
      request.fields['no_rekening'] = no_rekening;
      request.fields['a_n_rekening'] = a_n_rekening;
      request.fields['nama_tanda_tangan'] = nama_tanda_tangan;
      request.headers['Accept'] = "application/json";
      request.files.add(await http.MultipartFile.fromPath(
          'img_tanda_tangan', imageFile.path));

      var response = await request.send();
      String responseString = await response.stream.bytesToString();
      var responseBody = json.decode(responseString);
      if (response.statusCode == 200) {
        SnackbarWidget().snackbarSuccess("Berhasil Menambahkan Invoce");
        Get.offAll(
          DataTransportationPage(
            id_customer: int.parse(id_customer),
            isBack: 'false',
          ),
        );
        print(responseString);
      } else {
        SnackbarWidget().snackbarError(responseBody['message']);
        print(responseBody['message']);
      }
    } catch (e) {
      // SnackbarWidget().snackbarError(
      //     "Server Ada kendala atau mati, silahkan hubungi pihak pengembang");
      print(e);
    }
  }

  Future<File> _convertBytesToFile(List<int> tanda_tangan) async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String appDirPath = appDir.path;
    String filePath =
        '$appDirPath/image.png'; // Provide a file path with the desired extension (e.g., 'image.png')

    File file = File(filePath);
    await file.writeAsBytes(tanda_tangan);

    return file;
  }
}
