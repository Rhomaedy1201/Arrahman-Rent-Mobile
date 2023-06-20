import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:transportation_rent_mobile/utils/base_url.dart';
import 'package:transportation_rent_mobile/widget/itemProfile.dart';

class ProfileCompanyPage extends StatefulWidget {
  ProfileCompanyPage({super.key});

  @override
  State<ProfileCompanyPage> createState() => _ProfileCompanyPageState();
}

class _ProfileCompanyPageState extends State<ProfileCompanyPage> {
  List<Widget> icons = [
    const Icon(
      Icons.email_outlined,
      color: Colors.blue,
      size: 15,
    ),
    const Icon(
      Icons.location_city_outlined,
      color: Colors.blue,
      size: 15,
    ),
    const Icon(
      Icons.phone,
      color: Colors.blue,
      size: 15,
    ),
    const Icon(
      Icons.house_outlined,
      color: Colors.blue,
      size: 15,
    ),
    const Icon(
      Icons.location_on_outlined,
      color: Colors.blue,
      size: 15,
    ),
  ];

  @override
  void initState() {
    getCompany();
    super.initState();
  }

  // Get data Company for pdf Quotation and Invoice
  late Map<String, dynamic> dataCompany;
  var isLoading = false;
  void getCompany() async {
    setState(() {
      isLoading = true;
    });
    String url = "$baseUrl/data-company";

    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        dataCompany = json.decode(response.body)['data'][0];
        print(dataCompany);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  List listCompany = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          'Company Profile',
          style: TextStyle(fontSize: 18),
        ),
        foregroundColor: const Color(0xFF686868),
        elevation: 1,
      ),
      body: isLoading
          ? Center(
              child: Container(
                width: 60,
                height: 60,
                child: Lottie.asset('assets/lottie/loading.json'),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 15),
                  Container(
                    height: 50,
                    width: 60,
                    child:
                        Image.network('$urlWeb/storage/${dataCompany['logo']}'),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "List Profile",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF646464),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Column(
                    children: [
                      ItemProfile().listProfile(
                        dataCompany['email'],
                        dataCompany['nama_company'],
                        dataCompany['no_hp'],
                        dataCompany['kota'],
                        dataCompany['alamat'],
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
