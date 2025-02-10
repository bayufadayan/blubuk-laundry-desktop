// ignore_for_file: use_build_context_synchronously

import 'package:app_laundry_bismillah/views/dashboard/admin_list.dart';
import 'package:app_laundry_bismillah/views/dashboard/customer_info.dart';
import 'package:app_laundry_bismillah/views/dashboard/customer_list.dart';
import 'package:app_laundry_bismillah/views/dashboard/myprofile.dart';
import 'package:flutter/material.dart';
import 'package:app_laundry_bismillah/utils/session_manager.dart';
import 'package:app_laundry_bismillah/views/auth/login.dart';

import 'transaction_list.dart';

final List<String> items = [
  'New Order',
  'Daftar Customers',
  'Daftar Transaksi',
  'Daftar Admin',
  'My Profile',
  'Logout',
];

final List<IconData> icons = [
  Icons.add_shopping_cart,
  Icons.people,
  Icons.list,
  Icons.admin_panel_settings,
  Icons.person,
  Icons.logout,
];

void showMessage(String message) {
  // print(message);
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
  (context) => nagigatePageTo(context, CustomerInfo()),
  (context) => nagigatePageTo(context, CustomerList()),
  (context) => nagigatePageTo(context, TransactionList()),
  (context) => nagigatePageTo(context, AdminList()),
  (context) => nagigatePageTo(context, MyProfile()),
  (context) => logout(context),
];
