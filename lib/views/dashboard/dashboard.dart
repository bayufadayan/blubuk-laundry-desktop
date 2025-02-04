import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login.dart';
import 'dashboard_item_list.dart';
import 'dashboard_menu.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "BLUBUK Laundry",
          style: GoogleFonts.neucha(
              fontSize: 36,
              textStyle: const TextStyle(letterSpacing: 7.0),
              fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 80, 88),
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
                onPressed: () => _logout(context),
                child: Row(
                  children: [
                    Icon(Icons.logout_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Mau Keluar Bay?")
                  ],
                )),
          )
        ],
      ),
      // backgroundColor: Color(0xFFFFD0F5),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFD0F5),
              Color(0xFFB2EBF2),
              Color(0xFFFFD0F5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return DashboardMenu(title: items[index], icon: icons[index]);
            },
          ),
        ),
      ),
    );
  }
}
