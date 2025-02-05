import 'package:app_laundry_bismillah/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'dashboard_item_list.dart';
import 'dashboard_menu.dart';

class Dashboard extends StatelessWidget {
  final String adminName = 'admin';
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(isGetBack: false,),
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
              return DashboardMenu(
                title: items[index],
                icon: icons[index],
                onTap: () => functions[index](context),
              );
            },
          ),
        ),
      ),
    );
  }
}
