// ignore_for_file: unused_import, prefer_const_constructors

import 'package:app_laundry_bismillah/views/dashboard/customer_info.dart';
import 'package:app_laundry_bismillah/views/dashboard/history.dart';
import 'package:app_laundry_bismillah/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_laundry_bismillah/main.dart';
import 'package:http/http.dart' as http;

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  TextEditingController controllerWaktu = TextEditingController();
  TextEditingController controllerTanggal = TextEditingController();
  TextEditingController controllerMetodeAmbil = TextEditingController();
  TextEditingController controllerJenisLayanan = TextEditingController();
  TextEditingController controllerJenisBahan = TextEditingController();
  TextEditingController controllerBerat = TextEditingController();
  TextEditingController controllerHargaPokok = TextEditingController();

  void addData() {
    var url = "http://localhost:8080/blubuklaundry/adddata.php";

    http.post(Uri.parse(url), body: {
      "waktu": controllerWaktu.text,
      "tanggal": controllerTanggal.text,
      "metodeambil": controllerMetodeAmbil.text,
      "jenislayanan": controllerJenisLayanan.text,
      "jenisbahan": controllerJenisBahan.text,
      "berat": controllerBerat.text,
      "hargapokok": controllerHargaPokok.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
            padding: EdgeInsets.only(top: 130),
            alignment: Alignment.topCenter,
            child: Text(
              'INPUT DATA',
              style: GoogleFonts.openSans(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  textStyle: TextStyle(letterSpacing: 1.0)),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Container(
              width: 900,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: Color.fromRGBO(71, 71, 102, 1), width: 6.0),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const <Color>[
                      Color.fromARGB(255, 248, 232, 246),
                      Color.fromARGB(255, 219, 222, 241),
                      Color.fromARGB(255, 181, 186, 214),
                      Color.fromARGB(255, 149, 158, 211),
                    ]),
              ),
              child: Column(children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 15)),
                Column(children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Waktu',
                                style: GoogleFonts.roboto(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          Container(
                            alignment: Alignment.topLeft,
                            width: 120,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                                controller: controllerWaktu,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 1, 32, 44),
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: 'Jam bahara mhanks?',
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ]),
                        Padding(padding: EdgeInsets.only(left: 30)),
                        Column(children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Tanggal',
                                style: GoogleFonts.roboto(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          Container(
                            alignment: Alignment.topLeft,
                            width: 210,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                                controller: controllerTanggal,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 1, 32, 44),
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: 'Naik Tanggal',
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ]),
                        Padding(padding: EdgeInsets.only(left: 30)),
                        Column(children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Metode Pengambilan',
                                style: GoogleFonts.roboto(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          Container(
                            alignment: Alignment.topLeft,
                            width: 210,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                                controller: controllerMetodeAmbil,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 1, 32, 44),
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: 'cash or duel?',
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ]),
                        Padding(padding: EdgeInsets.only(left: 30)),
                        Column(children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Jenis Layanan',
                                style: GoogleFonts.roboto(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          Container(
                            alignment: Alignment.topLeft,
                            width: 210,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                                controller: controllerJenisLayanan,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 1, 32, 44),
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: 'Reguler/express/ekonomis',
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ]),
                      ]),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Container(
                    width: double.infinity,
                    height: 5,
                    color: Color.fromRGBO(71, 71, 102, 1),
                  ),
                  Padding(padding: EdgeInsets.only(top: 55)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        width: 450,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                            controller: controllerJenisBahan,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 1, 32, 44),
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: 'Masukan Nama Bahan',
                              labelText: 'Nama Bahan',
                              labelStyle: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                      Padding(padding: EdgeInsets.only(left: 14)),
                      Container(
                        alignment: Alignment.topLeft,
                        width: 150,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                            controller: controllerBerat,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 1, 32, 44),
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: 'Berat Londrian',
                              labelText: 'Berat',
                              labelStyle: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                      Padding(padding: EdgeInsets.only(left: 14)),
                      Container(
                        alignment: Alignment.topLeft,
                        width: 150,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                            controller: controllerHargaPokok,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 1, 32, 44),
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: 'Harga Sesuai Bahan per kilo',
                              labelText: 'Harga per Kilo',
                              labelStyle: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 35)),
                  Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        addData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const History()));
                      },
                      child: Image.asset(
                        "images/icon_next.png",
                        width: 52,
                        height: 52,
                      ),
                    );
                  }),
                ]),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
