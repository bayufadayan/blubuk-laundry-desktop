// ignore_for_file: use_build_context_synchronously

import 'package:app_laundry_bismillah/utils/config.dart';
import 'package:app_laundry_bismillah/widgets/my_text_field.dart';
import 'package:app_laundry_bismillah/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  int? adminId;

  @override
  void initState() {
    super.initState();
    _loadAdminData();
  }

  Future<void> _loadAdminData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? adminJson = prefs.getString('adminData');

    if (adminJson != null) {
      Map<String, dynamic> adminData = jsonDecode(adminJson);
      // print(adminData);
      setState(() {
        adminId = int.parse(adminData['id'].toString());
        nameController.text = adminData['name'] ?? '';
        emailController.text = adminData['email'] ?? '';
        phoneController.text = adminData['phone_number'] ?? '';
        addressController.text = adminData['address'] ?? '';
      });
    }
  }

  Future<void> updateData() async {
    if (adminId == null) return;

    if (passwordController.text.isNotEmpty &&
        passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password minimal 6 karakter'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Map<String, String> updatedData = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone_number': phoneController.text,
      'address': addressController.text,
    };

    if (passwordController.text.isNotEmpty) {
      updatedData['password'] = passwordController.text;
    }

    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}/updateAdminData.php'),
      body: {
        'id': adminId.toString(),
        ...updatedData,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil diperbarui')),
      );
      _saveUpdatedData(updatedData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui data')),
      );
    }
  }

  Future<void> _saveUpdatedData(Map<String, String> updatedData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> adminData = {
      'id': adminId,
      ...updatedData,
    };
    await prefs.setString('adminData', jsonEncode(adminData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(isGetBack: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
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
                "Berikut rincian data Anda, Anda dapat mengupdate data termasuk password.",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade700, width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: Colors.amber.shade700, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Silakan isi kolom password jika ingin mengganti password.",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              MyTextField(controller: nameController, label: "Nama Lengkap"),
              MyTextField(controller: emailController, label: "Email"),
              MyTextField(
                  controller: passwordController,
                  label: "Password",
                  obscureText: true),
              MyTextField(controller: phoneController, label: "Nomor WhatsApp"),
              MyTextField(
                  controller: addressController, label: "Alamat", maxLines: 3),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 68, 113, 212),
                    minimumSize: Size(double.infinity, 60),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: updateData,
                  child: Text("Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
