import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFunctionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyFunctionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(230, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
          side: const BorderSide(
            color: Color.fromRGBO(28, 82, 143, 1), // Warna border
            width: 2.5,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 138, 226, 238),
        foregroundColor: Colors.black, // Warna teks
        elevation: 4, // Efek bayangan tombol
        shadowColor: Colors.blueGrey,
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
