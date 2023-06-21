import 'dart:convert';

import 'package:get/get.dart';
import 'package:transportation_rent_mobile/utils/base_url.dart';

class transportationProvider extends GetConnect {
  String url = "$baseUrl/transportation";
  String urlUpdate = "$baseUrl/edit-transportation";

  Future<Response> postTransportation(
    int id_customer,
    String tipe_mobil,
    String lama_penggunaan,
    String jumlah,
    String tanggal_penggunaan,
    String harga,
    String tujuan,
  ) async {
    final body = json.encode({
      "id_customer": '$id_customer',
      "tipe_mobil": tipe_mobil,
      "lama_penggunaan": lama_penggunaan,
      "jumlah": jumlah,
      "tanggal_penggunaan": tanggal_penggunaan,
      "harga": harga,
      "tujuan": tujuan,
    });

    return post(url, body, headers: {'Accept': 'application/json'});
  }

  Future<Response> updateTransportation(
    int idTransportation,
    int id_customer,
    String tipe_mobil,
    String lama_penggunaan,
    String jumlah,
    String tanggal_penggunaan,
    String harga,
    String tujuan,
  ) async {
    final body = json.encode({
      "id_customer": '$id_customer',
      "tipe_mobil": tipe_mobil,
      "lama_penggunaan": lama_penggunaan,
      "jumlah": jumlah,
      "tanggal_penggunaan": tanggal_penggunaan,
      "harga": harga,
      "tujuan": tujuan,
    });

    return post('$urlUpdate/$idTransportation', body,
        headers: {'Accept': 'application/json'});
  }
}
