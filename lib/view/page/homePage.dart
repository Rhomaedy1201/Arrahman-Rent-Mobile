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
                  "Arahman Rent".toUpperCase(),
                  style: TextStyle(
                    fontSize: isMobile ? 19 : 23,
                    fontWeight: FontWeight.w700,
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
                    crossAxisCount: isMobile ? 2 : 4,
                    children: <Widget>[
                      ItemHome(isMobile: isMobile).createSignature,
                      ItemHome(isMobile: isMobile).createQuotation,
                      ItemHome(isMobile: isMobile).searchDataQuotation,
                      ItemHome(isMobile: isMobile).changeCompany,
                    ],
                  ),
                ),
                // SizedBox(
                //   width: double.infinity,
                //   child: GridView.builder(
                //     shrinkWrap: true,
                //     gridDelegate:
                //         const SliverGridDelegateWithMaxCrossAxisExtent(
                //       maxCrossAxisExtent: 200,
                //     ),
                //     itemBuilder: (context, index) {
                //       return Container();
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
