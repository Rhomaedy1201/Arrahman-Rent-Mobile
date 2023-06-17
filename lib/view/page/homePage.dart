import 'package:flutter/material.dart';
import 'package:transportation_rent_mobile/widget/itemHome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo/logo.png'),
                        fit: BoxFit.contain,
                      ),
                      // color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  "Arahman Rent".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 400,
                  // color: Colors.amber,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    children: <Widget>[
                      ItemHome().createSignature,
                      ItemHome().createQuotation,
                      ItemHome().searchDataQuotation,
                      ItemHome().changeCompany,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
