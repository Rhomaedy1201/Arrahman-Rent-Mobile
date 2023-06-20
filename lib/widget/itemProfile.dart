import 'package:flutter/material.dart';

class ItemProfile {
  Widget listProfile(
    String email,
    String namaCompany,
    String phone,
    String kota,
    String alamat,
  ) {
    //format phone Company
    String? formattedPhoneCompany;
    if (phone.contains('[') && phone.contains(']')) {
      formattedPhoneCompany =
          phone.replaceRange(5, 5, ' ').replaceRange(9, 9, ' ');
    } else {
      formattedPhoneCompany = phone.replaceAllMapped(
          RegExp(r".{4}"), (match) => "${match.group(0)} ");
    }

    return Column(
      children: [
        //Email
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: const Color(0xFFDCDCDC),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    Icons.email_outlined,
                    color: Colors.blue,
                    size: 15,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 260,
                  child: Text(
                    email,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Nama Company
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: const Color(0xFFDCDCDC),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    Icons.location_city_outlined,
                    color: Colors.blue,
                    size: 15,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 260,
                  child: Text(
                    namaCompany,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Phone
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: const Color(0xFFDCDCDC),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    Icons.phone,
                    color: Colors.blue,
                    size: 15,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 260,
                  child: Text(
                    '+62 $formattedPhoneCompany',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Kota
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: const Color(0xFFDCDCDC),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    Icons.house_outlined,
                    color: Colors.blue,
                    size: 15,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 260,
                  child: Text(
                    kota,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Alamat
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: const Color(0xFFDCDCDC),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.blue,
                    size: 15,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 260,
                  child: Text(
                    alamat,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
