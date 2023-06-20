import 'package:flutter/material.dart';

class DataQuotation {
  Column data(
    String nama,
    String no_hp,
    String perusahaan,
    String kota,
    String pos,
    String alamat,
    String email,
  ) {
    String? formattedPhoneNumber;
    if (no_hp.contains('[') && no_hp.contains(']')) {
      formattedPhoneNumber =
          no_hp.replaceRange(5, 5, ' ').replaceRange(9, 9, ' ');
    } else {
      formattedPhoneNumber = no_hp.replaceAllMapped(
          RegExp(r".{4}"), (match) => "${match.group(0)} ");
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          color: const Color(0xFFF9F9F9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nama",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                Container(
                  width: 250,
                  child: Text(nama,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF505050),
                      )),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: const Color(0xFFF4F4F4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("No Hanphone",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                Text('+62 $formattedPhoneNumber',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF505050),
                    )),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: const Color(0xFFF9F9F9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nama Perusahaan",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                Container(
                  width: 200,
                  child: Text(perusahaan,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF505050),
                      )),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: const Color(0xFFF4F4F4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Kota/pos",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                Text("$kota/$pos",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF505050),
                    )),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: const Color(0xFFF9F9F9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Alamat",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                Container(
                  width: 250,
                  child: Text(alamat,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF505050),
                      )),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: const Color(0xFFF4F4F4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Email",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    )),
                Container(
                  width: 300,
                  child: Text(email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF505050),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
