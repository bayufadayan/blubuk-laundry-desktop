abstract class Person {
  final String name;
  final String phoneNumber;

  Person({required this.name, required this.phoneNumber});
}

class Admin extends Person {
  final String email;
  final String password;
  final String address;

  Admin({
    required super.name,
    required super.phoneNumber,
    required this.email,
    required this.password,
    required this.address,
  });
}

class Customer extends Person {
  String address;
  DateTime firstOrder;
  DateTime lastOrder;

  Customer({
    required super.name,
    required super.phoneNumber,
    this.address = "Tidak disebutkan",
    required this.firstOrder,
    required this.lastOrder,
  });
}

class Transaction {
  final String invoice;
  final DateTime timestamp;
  final Customer customer;
  final List<LaundryItem> items;
  final LaundryService serviceType;
  
  Transaction({
    required this.invoice,
    required this.timestamp,
    required this.customer,
    required this.items,
    required this.serviceType,
  });
}

enum LaundryService { express, regular }

enum LaundryCategory { satuan, kiloan }

abstract class LaundryItem {
  final String name;
  final LaundryCategory category;
  final double price;

  LaundryItem({required this.name, required this.category, required this.price});
}

class SatuanLaundry extends LaundryItem {
  SatuanLaundry({required super.name, required super.price})
      : super(category: LaundryCategory.satuan);
}

class KiloanLaundry extends LaundryItem {
  KiloanLaundry({required double pricePerKg})
      : super(name: "Kiloan", category: LaundryCategory.kiloan, price: pricePerKg);
}
