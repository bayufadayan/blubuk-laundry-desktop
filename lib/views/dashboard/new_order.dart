// ignore_for_file: unused_import, prefer_const_constructors

import 'package:app_laundry_bismillah/views/dashboard/customer_info.dart';
import 'package:app_laundry_bismillah/views/dashboard/history.dart';
import 'package:app_laundry_bismillah/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_laundry_bismillah/main.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:core';

String generateInvoice() {
  final now = DateTime.now();
  final random = Random();
  final letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  return '${letters[random.nextInt(letters.length)]}${letters[random.nextInt(letters.length)]}-${now.millisecondsSinceEpoch.toString().substring(6)}';
}

class NewOrder extends StatefulWidget {
  final String customerId;

  const NewOrder({super.key, required this.customerId});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final timeNow = DateTime.now();
  TextEditingController controllerWaktu = TextEditingController();
  TextEditingController controllerLayanan = TextEditingController();
  TextEditingController controllerMetodeAmbil = TextEditingController();
  TextEditingController controllerJenisLayanan = TextEditingController();
  TextEditingController controllerJenisBahan = TextEditingController();
  TextEditingController controllerBerat = TextEditingController();
  TextEditingController controllerHargaPokok = TextEditingController();
  final String invoice = generateInvoice();

  @override
  void initState() {
    super.initState();
    controllerWaktu.text = DateTime.now().toString();
  }

  void addData() {
    var url = "http://localhost:8080/blubuklaundry/adddata.php";

    http.post(Uri.parse(url), body: {
      "waktu": controllerWaktu.text,
      "tanggal": controllerLayanan.text,
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
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buat Order Baru',
                    style: GoogleFonts.openSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        textStyle: TextStyle(letterSpacing: 1.0)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        width: 280,
                        height: 475,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Informasi Customer",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(height: 8),
                            Divider(thickness: 1, color: Colors.grey[300]),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Invoice:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                  invoice,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Nama:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                  "Magitassz",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("No. Telp:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                  "325492384",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 900,
                        height: 475,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Color.fromRGBO(71, 71, 102, 1),
                              width: 0.0),
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
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Detail Transaksi",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Divider(thickness: 1, color: Colors.black),
                              SizedBox(height: 8),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 6,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  width: 175,
                                                  height: 50,
                                                  // height: 38,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: TextField(
                                                    controller: controllerWaktu,
                                                    enabled: false,
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors
                                                            .blue.shade900),
                                                    decoration: InputDecoration(
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                      label: Text(
                                                        "Waktu",
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide: BorderSide(
                                                            color: Colors.blue),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide: BorderSide(
                                                            color: Colors.blue),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide: BorderSide(
                                                            color: Colors.blue),
                                                      ),
                                                      hintStyle:
                                                          GoogleFonts.roboto(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  width: 200,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value: "Regular",
                                                    items: [
                                                      "Regular",
                                                      "Express"
                                                    ].map((String item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: item,
                                                        child: Text(item,
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      1,
                                                                      32,
                                                                      44),
                                                            )),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      // Handle perubahan pilihan
                                                      print("Selected: $value");
                                                    },
                                                    decoration: InputDecoration(
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                      label: Text(
                                                          "Pilihan Layanan"),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide: BorderSide(
                                                            color: Colors.blue),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide: BorderSide(
                                                            color: Colors.blue),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide: BorderSide(
                                                            color: Colors.blue),
                                                      ),
                                                      hintText:
                                                          "Regular / Express",
                                                      hintStyle:
                                                          GoogleFonts.roboto(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Total Tagihan',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                                Text(
                                                  'Rp. 56.000',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 16.0),
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.add,
                                                  color: Colors.white),
                                              SizedBox(width: 10),
                                              Text(
                                                "Tambah Item Laundry",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),

                                        // ini column buat nambah item
                                        SizedBox(
                                          height: 165,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      "1. ",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      width: 300,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white60,
                                                        borderRadius:
                                                            BorderRadius.circular(8),
                                                      ),
                                                      child: DropdownButtonFormField<
                                                          String>(
                                                        value: null,
                                                        items: [
                                                          "Cuci Kering",
                                                          "Cuci Basah",
                                                          "Setrika"
                                                        ].map((String item) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: item,
                                                            child: Text(item,
                                                                style:
                                                                    GoogleFonts.roboto(
                                                                  fontWeight:
                                                                      FontWeight.w500,
                                                                  color: Color.fromARGB(
                                                                      255, 1, 32, 44),
                                                                )),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          print("Selected: $value");
                                                        },
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    8),
                                                          ),
                                                          labelText: "Kategori",
                                                          hintText: "Pilih Kategori",
                                                          labelStyle:
                                                              GoogleFonts.roboto(
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          hintStyle: GoogleFonts.roboto(
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                
                                                    // Input Berat/Qty
                                                    Container(
                                                      width: 100,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white60,
                                                        borderRadius:
                                                            BorderRadius.circular(8),
                                                      ),
                                                      child: TextField(
                                                        controller: controllerBerat,
                                                        keyboardType:
                                                            TextInputType.number,
                                                        style: GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          color: Color.fromARGB(
                                                              255, 1, 32, 44),
                                                        ),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    8),
                                                          ),
                                                          labelText: 'Berat/Qty (Kg)',
                                                          hintText: 'Masukkan jumlah',
                                                          labelStyle:
                                                              GoogleFonts.roboto(
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          hintStyle: GoogleFonts.roboto(
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Container(
                                                      width: 150,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white60,
                                                        borderRadius:
                                                            BorderRadius.circular(8),
                                                      ),
                                                      child: TextField(
                                                        controller: controllerBerat,
                                                        enabled: false,
                                                        keyboardType:
                                                            TextInputType.number,
                                                        style: GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          color: Color.fromARGB(
                                                              255, 1, 32, 44),
                                                        ),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    8),
                                                          ),
                                                          labelText: 'Rp 35.000',
                                                          hintText: 'Harga Satuan',
                                                          labelStyle:
                                                              GoogleFonts.roboto(
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          hintStyle: GoogleFonts.roboto(
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 20),
                                                
                                                    // Total Harga
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Sub Total Item",
                                                          style: GoogleFonts.roboto(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black54,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Rp 56.000",
                                                          style: GoogleFonts.roboto(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 68, 113, 212),
                                          minimumSize:
                                              Size(double.infinity, 60),
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text("Next"),
                                      ),
                                    ),
                                  ]),
                            ]),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
