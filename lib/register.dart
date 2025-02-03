import 'package:app_laundry_bismillah/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main(List<String> args) {}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            //background
            Container(color: const Color.fromARGB(255, 252, 230, 169)),
            //wallpaper
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                "images/first_pattern.png",
              ),
            ),
            //registerpahe
            SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 20)),
                Center(
                  child: Text(
                    'Silakan Daftar',
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700, fontSize: 30),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  width: 440,
                  height: 560,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color.fromRGBO(240, 173, 229, 1),
                            Color.fromRGBO(202, 231, 243, 1),
                          ]),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7)
                      ]),
                  child: Column(
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(top: 23)),
                      SizedBox(
                        width: 500,
                        height: 500,
                        child: Column(children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 24),
                            child: Text('Nama Lengkap',
                                style: GoogleFonts.roboto(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 3.7)),
                          Container(
                            alignment: Alignment.topLeft,
                            width: 400,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 1, 32, 44),
                                ),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Masukin ath Namanya',
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 24),
                            child: Text('Email',
                                style: GoogleFonts.roboto(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 3.7)),
                          Container(
                            alignment: Alignment.topLeft,
                            width: 400,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 1, 32, 44),
                                ),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Email lu apaan?',
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 24),
                            child: Text('Username',
                                style: GoogleFonts.roboto(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 3.7)),
                          Container(
                            alignment: Alignment.topLeft,
                            width: 400,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 1, 32, 44),
                                ),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Masukin username',
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 24),
                            child: Text('Password',
                                style: GoogleFonts.roboto(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 3.7)),
                          Container(
                            alignment: Alignment.topLeft,
                            width: 400,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Masukin passwordnya',
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 24),
                            child: Text('Nomor Telepon',
                                style: GoogleFonts.roboto(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 3.7)),
                          Container(
                            alignment: Alignment.topLeft,
                            width: 400,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 1, 32, 44),
                                ),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Masukin NO telp',
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 24),
                            child: Text('Jenjang Pendidikan Terakhir',
                                style: GoogleFonts.roboto(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 3.7)),
                          Container(
                            alignment: Alignment.topLeft,
                            width: 400,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 1, 32, 44),
                                ),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'smp/sma/s1?',
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              height: 43.3,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 170, 218, 250),
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 50, 102, 168),
                                      width: 3.0)),
                              child: Text('Sign in',
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20)),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 5)),
                          Builder(builder: (context) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                              },
                              child: Text('Sudah punya akun? Masuk disini',
                                  style: GoogleFonts.roboto(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      textStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 6, 49, 85)))),
                            );
                          }),
                          // Padding(padding: EdgeInsets.only(bottom: 20)),
                        ]),
                      ),
                    ],
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
