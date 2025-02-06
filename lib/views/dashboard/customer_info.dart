// ignore_for_file: prefer_const_constructors

import 'package:app_laundry_bismillah/views/auth/login.dart';
import 'package:app_laundry_bismillah/views/dashboard/new_order.dart';
import 'package:app_laundry_bismillah/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerInfo extends StatefulWidget {
  const CustomerInfo({super.key});

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app Bar
      appBar: MyAppBar(isGetBack: true),
      body: Stack(
        children: <Widget>[
          //bg
          Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(colors: const <Color>[
              Color.fromRGBO(252, 254, 252, 1),
              Color.fromARGB(255, 252, 239, 249),
            ])),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "images/second_pattern.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 430,
                height: 460,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: Color.fromARGB(255, 29, 29, 31), width: 6.0),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: const <Color>[
                        Color.fromRGBO(255, 255, 255, 1),
                        Color.fromRGBO(151, 159, 228, 1),
                      ]),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 16)),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(children: <Widget>[
                            Text('Customer',
                                style: GoogleFonts.neucha(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w700,
                                    textStyle: TextStyle(letterSpacing: 5.0))),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: Text(
                                'Silakan pilih customer atau isi kolom untuk menambah customer baru',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text('Masukan dan Pilih Customers',
                                  style: GoogleFonts.roboto(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left),
                            ),
                            Padding(padding: EdgeInsets.only(top: 3.7)),
                            Container(
                              alignment: Alignment.topLeft,
                              width: double.infinity,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 1, 32, 44),
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: 'Masukan nama customers',
                                    hintStyle: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Divider(
                                thickness: 1.4,
                                color: const Color.fromARGB(255, 126, 126, 126),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text('Nama Customers',
                                  style: GoogleFonts.roboto(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left),
                            ),
                            Padding(padding: EdgeInsets.only(top: 3.7)),
                            Container(
                              alignment: Alignment.topLeft,
                              width: double.infinity,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                  keyboardType: TextInputType.name,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 1, 32, 44),
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: 'Masukan Nama Customers',
                                    hintStyle: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                            ),
                            Padding(padding: EdgeInsets.only(top: 9)),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text('Nomor WhatsApp',
                                  style: GoogleFonts.roboto(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left),
                            ),
                            Padding(padding: EdgeInsets.only(top: 3.7)),
                            Container(
                              alignment: Alignment.topLeft,
                              width: double.infinity,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 1, 32, 44),
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: 'Masukan Nomor WhatsApp',
                                    hintStyle: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 68, 113, 212),
                                  minimumSize: Size(double.infinity, 60),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewOrder(),
                                    ),
                                  );
                                },
                                child: Text("Next"),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
