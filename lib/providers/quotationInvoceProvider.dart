// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:transportation_rent_mobile/utils/base_url.dart';

// class QuotationInvoiceProvider extends GetConnect {
//   String url = "$baseUrl/customer";

//   Future<Response> postQuotation(
//     int id_customer,
//     String tanda_penerima_pembayaran,
//     String keterangan,
//     String periode_pembayaran,
//     String metode_pembayaran,
//     String nama_bank,
//     String no_rekening,
//     String a_n_rekening,
//     String nama_tanda_tangan,
//     String img_tanda_tangan,
//   ) async {
//     final body = json.encode({
//       'kutipan_sewa': kutipan_sewa,
//       'nama_customer': nama_cus,
//       'email': email,
//       'nama_perusahaan': nama_perusahaan,
//       'kota': kota,
//       'nama_jalan': detail_alamat,
//       'kode_pos': pos,
//       'no_hp': no_hp,
//       'tanggal': tanggal,
//       'no_quotation': no_quotation,
//       'komentar': komentar,
//       'total_harga': total_harga,
//       'id_user': id_user_ttd,
//     });

//     return post(url, body, headers: {'Accept': 'application/json'});
//   }
// }
