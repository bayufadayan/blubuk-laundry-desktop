// ignore_for_file: use_build_context_synchronously

import 'package:app_laundry_bismillah/utils/config.dart';
import 'package:app_laundry_bismillah/views/auth/login.dart';
import 'package:app_laundry_bismillah/widgets/myfunction_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(List<String> args) {}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isPasswordHidden = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _errorMessage = '';

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        setState(() {
          _errorMessage = 'Password dan Konfirmasi Password tidak sama';
        });
        return;
      }

      if (_passwordController.text.length < 6) {
        setState(() {
          _errorMessage = 'Password minimal 6 karakter';
        });
        return;
      }

      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/register.php'),
        body: {
          'name': _nameController.text,
          'phone_number': _phoneController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'address': _addressController.text,
        },
      );

      final responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Registrasi berhasil!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 2),
          ),
        );

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        });
      } else {
        setState(() {
          _errorMessage = responseData['message'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //background
          Container(color: const Color.fromARGB(255, 252, 230, 169)),
          //wallpaper
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "images/first_pattern.png",
              fit: BoxFit.cover,
            ),
          ),

          //registerpage
          SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 20)),
                Center(
                  child: Text(
                    'Daftar Akun  ',
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700, fontSize: 30),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  width: 440,
                  height: 600,
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
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      SizedBox(
                        child: Column(children: <Widget>[
                          if (_errorMessage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors
                                      .red.shade100, // Background merah muda
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.red.shade400, width: 1.5),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.error,
                                        color: Colors.red, size: 20),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _errorMessage,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight
                                              .w600, // Teks lebih tegas
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                                controller: _nameController,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 1, 32, 44),
                                ),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Nama Lengkap Anda',
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
                                controller: _emailController,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 1, 32, 44),
                                ),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'emailkamu@gmail.com',
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
                              controller: _passwordController,
                              obscureText: _isPasswordHidden,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 1, 32, 44),
                              ),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'Password Anda',
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color.fromARGB(255, 1, 32, 44),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordHidden = !_isPasswordHidden;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 24),
                            child: Text('Konfirmasi Password',
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
                              controller: _confirmPasswordController,
                              obscureText: _isPasswordHidden,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 1, 32, 44),
                              ),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'Masukan ulang Password',
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color.fromARGB(255, 1, 32, 44),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordHidden = !_isPasswordHidden;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 6)),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 24),
                            child: Text('Nomor Whatsapp',
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
                                controller: _phoneController,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 1, 32, 44),
                                ),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Nomer Whatsapp Aktif Anda',
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
                            child: Text('Alamat Lengkap',
                                style: GoogleFonts.roboto(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 3.7)),
                          Container(
                            alignment: Alignment.topLeft,
                            width: 400,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                                controller: _addressController,
                                maxLines: 3,
                                minLines: 3,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 1, 32, 44),
                                ),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Alamat lengkap Anda',
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          MyFunctionButton(
                              text: "Sign Up", onPressed: _register),
                          const Padding(padding: EdgeInsets.only(top: 5)),
                          Builder(builder: (context) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                              },
                              child: Text(
                                'Sudah punya akun? Masuk disini',
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 6, 49, 85),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
