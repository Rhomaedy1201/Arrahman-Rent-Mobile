import 'package:get/get.dart';
import 'package:transportation_rent_mobile/providers/trasnsportationProvider.dart';
import 'package:transportation_rent_mobile/view/page/dataTransportasionPage.dart';
import 'package:transportation_rent_mobile/widget/snackbarWidget.dart';

class TransportationController {
  void postTransportation(
    int id_customer,
    String tipe_mobil,
    String lama_penggunaan,
    String jumlah,
    String tanggal_penggunaan,
    String harga,
    String tujuan,
  ) {
    try {
      transportationProvider()
          .postTransportation(
        id_customer,
        tipe_mobil,
        lama_penggunaan,
        jumlah,
        tanggal_penggunaan,
        harga,
        tujuan,
      )
          .then((response) {
        if (response.statusCode == 200) {
          SnackbarWidget().snackbarSuccess(response.body['message']);
          Get.offAll(DataTransportationPage(
            id_customer: id_customer,
            isBack: 'false',
          ));
        } else {
          SnackbarWidget().snackbarError(response.body['message']);
          print(response.statusCode);
        }
      });
    } catch (e) {
      // SnackbarWidget().snackbarError(
      //     "Server Ada kendala atau mati, silahkan hubungi pihak pengembang");
      print(e);
    }
  }
}
