import 'package:flutter/material.dart';

class DashboardMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardMenu(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor:
            Colors.transparent,
      ),
      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 241, 112, 155),
              Colors.pink.shade100
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.shade300.withOpacity(0.5),
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Color.fromARGB(255, 241, 112, 155),
                size: 50,
              ),
              SizedBox(height: 10.0),
              Text(
                title,
                style: TextStyle(
                  color: Color.fromARGB(255, 241, 112, 155),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ComicSans',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
