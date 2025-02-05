import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_laundry_bismillah/views/auth/login.dart';
import 'package:app_laundry_bismillah/utils/session_manager.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isGetBack;
  const MyAppBar({super.key, required this.isGetBack});

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  Future<Map<String, dynamic>?> getAdmin() async {
    return await SessionManager.getAdminData();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        "BLUBUK Laundry",
        style: GoogleFonts.neucha(
          fontSize: 36,
          textStyle: const TextStyle(letterSpacing: 7.0),
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: isGetBack
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
          child: FutureBuilder<Map<String, dynamic>?>(
            future: getAdmin(),
            builder: (context, snapshot) {
              String adminName = "Admin";
              if (snapshot.connectionState == ConnectionState.waiting) {
                adminName = "Loading...";
              } else if (snapshot.hasData && snapshot.data != null) {
                adminName = snapshot.data!['name'];
              }

              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 80, 88),
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
                onPressed: () => _logout(context),
                child: Row(
                  children: [
                    Icon(Icons.logout_rounded),
                    SizedBox(width: 10),
                    Text("Mau Keluar, $adminName?")
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight); // Mengatur tinggi AppBar
}
