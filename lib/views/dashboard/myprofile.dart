import 'package:app_laundry_bismillah/widgets/my_text_field.dart';
import 'package:app_laundry_bismillah/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(isGetBack: true),
      body: Padding(
        padding: EdgeInsets.only(top: 30, left: 50, right: 50, bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Profile",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Berikut rincian data data Anda, anda dapat mengupdate data anda termasuk password",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100, // Background warna soft
                  borderRadius: BorderRadius.circular(8), // Bikin rounded
                  border: Border.all(
                      color: Colors.amber.shade700, width: 1), // Tambah border
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: Colors.amber.shade700, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Silakan isi kolom password jika ingin mengganti password.",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextField(
                          controller: nameController, label: "Nama Lengkap"),
                      MyTextField(controller: emailController, label: "Email"),
                      MyTextField(
                        controller: passwordController,
                        label: "Password",
                        obscureText: true,
                      ),
                      MyTextField(
                          controller: phoneController, label: "Nomor WhatsApp"),
                      MyTextField(
                          controller: addressController,
                          label: "Alamat",
                          maxLines: 3),
                      SizedBox(height: 0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 68, 113, 212),
                            minimumSize: Size(
                                double.infinity, 60), 
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            print("Nama: ${nameController.text}");
                            print("Email: ${emailController.text}");
                            print("Password: ${passwordController.text}");
                            print("Nomor WA: ${phoneController.text}");
                            print("Alamat: ${addressController.text}");
                          },
                          child: Text("Simpan"),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
