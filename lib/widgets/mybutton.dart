import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Widget destination;

  const MyButton({super.key, required this.text, required this.destination});

  @override
  Widget build(BuildContext context) {
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
                color: const Color.fromRGBO(28, 82, 143, 1), width: 2.5)),
        child: Text(text,
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18),
            textAlign: TextAlign.center),
      ),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
}
