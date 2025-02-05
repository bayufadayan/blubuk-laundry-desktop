import 'package:app_laundry_bismillah/views/auth/login.dart';
import 'package:app_laundry_bismillah/widgets/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          height: double.infinity,
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            "images/bubble.png",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 170)),
                Image.asset("images/blubuk_logo.png", width: 180, height: 180),
                // Image.asset("images/blubuk 2.0.png", width: 300, height: 300),
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
                MyButton(
                  text: 'Get Started',
                  destination: Login(),
                ),
                // Image.asset("images/bubble_down.png"),
              ]),
        )
      ]),
    );
  }
}
