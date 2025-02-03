import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_laundry_bismillah/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color.fromRGBO(226, 232, 255, 1),
                    Color.fromRGBO(226, 232, 255, 1),
                    Color.fromRGBO(226, 232, 255, 1),
                    Color.fromRGBO(248, 217, 246, 1)
                  ]),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Image.asset("images/bubble.png"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 170)),
                  Image.asset("images/blubuk_logo.png",
                      width: 180, height: 180),
                  const Padding(padding: EdgeInsets.only(top: 5.0)),
                  Text(
                    "BLUBUK",
                    style: GoogleFonts.neucha(
                        fontSize: 50,
                        textStyle: const TextStyle(letterSpacing: 7.0),
                        fontWeight: FontWeight.w500),
                  ),
                  Text('cleaning with heart',
                      style: GoogleFonts.indieFlower(
                          fontSize: 20,
                          textStyle: const TextStyle(letterSpacing: 5.0),
                          fontWeight: FontWeight.w500)),
                  const Padding(padding: EdgeInsets.only(top: 30.0)),
                  Builder(builder: (context) {
                    return InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: 230,
                        height: 43.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Color.fromARGB(255, 138, 226, 238),
                                  Color.fromRGBO(192, 221, 248, 1),
                                ]),
                            border: Border.all(
                                color: const Color.fromRGBO(28, 82, 143, 1),
                                width: 2.5)),
                        child: Text('Get Started',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 18),
                            textAlign: TextAlign.center),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                    );
                  }),
                  // Image.asset("images/bubble_down.png"),
                ]),
          )
        ]),
      ),
    );
  }
}
