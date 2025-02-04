import 'package:app_laundry_bismillah/views/dashboard/customer_info.dart';
import 'package:app_laundry_bismillah/views/auth/register.dart';
import 'package:app_laundry_bismillah/widgets/mybutton.dart';
import 'package:app_laundry_bismillah/widgets/myfunction_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //background color
          Container(color: const Color.fromARGB(255, 252, 230, 169)),
          //wallpaper

          Container(
            alignment: Alignment.center,
            child: Image.asset(
              "images/first_pattern.png",
            ),
          ),
          //content login
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 15)),
              Center(
                  child: Text('Silakan Masuk',
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w700, fontSize: 30))),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                width: 440,
                height: 360,
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
                    Container(
                      width: 500,
                      height: 200,
                      color: Colors.transparent,
                      child: Column(children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 24),
                          child: Text('Email',
                              style: GoogleFonts.roboto(
                                  fontSize: 13.5, fontWeight: FontWeight.w500),
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
                                hintText: 'Masukan Email Anda',
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 24),
                          child: Text('Password',
                              style: GoogleFonts.roboto(
                                  fontSize: 13.5, fontWeight: FontWeight.w500),
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
                            // controller: _passwordController,
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
                      ]),
                    ),
                    MyFunctionButton(text: "Login", onPressed: () {}),
                    const Padding(padding: EdgeInsets.only(top: 5)),
                    Builder(builder: (context) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
                        },
                        child: Text('Belum punya akun? Daftar disini',
                            style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 6, 49, 85)))),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
