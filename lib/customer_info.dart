// ignore_for_file: prefer_const_constructors

import 'package:app_laundry_bismillah/login.dart';
import 'package:app_laundry_bismillah/new_order.dart';
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
    return MaterialApp(
        home: Scaffold(
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
          Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Image.asset("images/second_pattern.png"),
          ),
          //app Bar
          Container(
              width: double.infinity,
              height: 67,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const <Color>[
                      Color.fromRGBO(119, 191, 242, 1),
                      Color.fromRGBO(212, 231, 244, 1),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7)
                  ]),
              child: Row(children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 20)),
                Builder(builder: (context) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: Image.asset(
                      "images/icon_back.png",
                      width: 34,
                      height: 34,
                    ),
                  );
                }),
                Padding(padding: EdgeInsets.only(left: 13)),
                Text('Customer Ingfo',
                    style: GoogleFonts.openSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        textStyle: TextStyle(letterSpacing: 3.0)))
              ])),

          Center(
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
              child: Column(children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 30)),
                Column(children: <Widget>[
                  Text('Blubuk Laundry',
                      style: GoogleFonts.neucha(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          textStyle: TextStyle(letterSpacing: 5.0))),
                  Text('cleaning with heart',
                      style: GoogleFonts.indieFlower(
                          fontSize: 14,
                          textStyle: TextStyle(letterSpacing: 5.0),
                          fontWeight: FontWeight.w500)),
                  Padding(padding: EdgeInsets.only(top: 18)),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 26),
                    child: Text('Email',
                        style: GoogleFonts.roboto(
                            fontSize: 13.5, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left),
                  ),
                  Padding(padding: EdgeInsets.only(top: 3.7)),
                  Container(
                    alignment: Alignment.topLeft,
                    width: 378,
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
                          hintText: 'Email lu apaan?',
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                  Padding(padding: EdgeInsets.only(top: 9)),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 26),
                    child: Text('Alamat',
                        style: GoogleFonts.roboto(
                            fontSize: 13.5, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left),
                  ),
                  Padding(padding: EdgeInsets.only(top: 3.7)),
                  Container(
                    alignment: Alignment.topLeft,
                    width: 378,
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
                          hintText: 'Masukin Alamat',
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                  Padding(padding: EdgeInsets.only(top: 9)),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 26),
                    child: Text('Nomor Telepon',
                        style: GoogleFonts.roboto(
                            fontSize: 13.5, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left),
                  ),
                  Padding(padding: EdgeInsets.only(top: 3.7)),
                  Container(
                    alignment: Alignment.topLeft,
                    width: 378,
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
                          hintText: 'Boleh kali',
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                  Padding(padding: EdgeInsets.only(top: 35)),
                  Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewOrder()));
                      },
                      child: Image.asset(
                        "images/icon_next.png",
                        width: 43,
                        height: 43,
                      ),
                    );
                  }),
                ]),
              ]),
            ),
          ),
        ],
      ),
    ));
  }
}
