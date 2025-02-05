import 'package:app_laundry_bismillah/views/dashboard/admin_list.dart';
import 'package:flutter/material.dart';
import 'package:app_laundry_bismillah/utils/session_manager.dart';
import 'package:app_laundry_bismillah/views/auth/login.dart';

final List<String> items = [
  'New Order',
  'Daftar Antrian',
  'Daftar Transaksi',
  'Daftar Admin',
  'My Profile',
  'Logout',
];

final List<IconData> icons = [
  Icons.add_shopping_cart,
  Icons.queue,
  Icons.list,
  Icons.admin_panel_settings,
  Icons.person,
  Icons.logout,
];

void showMessage(String message) {
  print(message);
}

void nagigatePageTo(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

void logout(BuildContext context) async {
  await SessionManager.logout();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Login()), // Arahkan ke login
  );
}

List<Function(BuildContext)> functions = [
  (context) => showMessage("Tambah item ke keranjang"),
  (context) => showMessage("Antri"),
  (context) => showMessage("Lihat daftar"),
  (context) => nagigatePageTo(context, AdminList()),
  (context) => showMessage("Profil"),
  (context) => logout(context),
];
