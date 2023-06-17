import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transportation_rent_mobile/utils/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:transportation_rent_mobile/view/page/homePage.dart';
import 'package:transportation_rent_mobile/widget/snackbarWidget.dart';

class SignatureUserController {
  Rxn<File> imageFile = Rxn<File>();
  String url = "$baseUrl/user";

  Future<void> addSignatureUser(
      String nama_lengkap, List<int> tanda_tangan) async {
    try {
      File imageFile = await _convertBytesToFile(tanda_tangan);
      // Make API post request
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['nama_lengkap'] = nama_lengkap;
      request.headers['Accept'] = "application/json";
      request.files.add(
          await http.MultipartFile.fromPath('tanda_tangan', imageFile.path));

      var response = await request.send();
      String responseString = await response.stream.bytesToString();
      var responseBody = json.decode(responseString);
      if (response.statusCode == 200) {
        SnackbarWidget().snackbarSuccess("Berhasil Membuat tanda tangan");
        Get.offAll(HomePage());
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
