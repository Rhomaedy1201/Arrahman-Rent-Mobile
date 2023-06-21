import 'package:flutter/material.dart';
import 'package:transportation_rent_mobile/widget/itemHome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List list = [
    'data 1',
    'data 2',
    'data 3',
    'data 4',
  ];
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.shortestSide < 600;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 30, vertical: isMobile ? 15 : 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: isMobile ? 200 : 300,
                    height: isMobile ? 50 : 70,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo/logo.png'),
                        fit: BoxFit.contain,
                      ),
                      // color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 40 : 80),
                Text(
                  "Menu Home",
                  style: TextStyle(
                    fontSize: isMobile ? 17 : 22,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF424242),
                  ),
                ),
                SizedBox(height: isMobile ? 10 : 20),
                Container(
                  width: double.infinity,
                  // height: 400,
                  // color: Colors.amber,
                  child: GridView.count(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    children: <Widget>[
                      ItemHome().createSignature(isMobile),
                      ItemHome().createQuotation(isMobile),
                      ItemHome().searchDataQuotation(isMobile),
                      ItemHome().changeCompany(isMobile),
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
