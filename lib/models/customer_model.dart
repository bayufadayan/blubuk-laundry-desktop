import 'person_model.dart';

class Customer extends Person {
  final int id;
  String address;
  DateTime? firstOrder;
  DateTime? lastOrder;

  Customer({
    required this.id,
    required super.name,
    required super.phoneNumber,
    this.address = "Tidak disebutkan",
    this.firstOrder,
    this.lastOrder,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: int.parse(json['id']),
      name: json['name'],
      phoneNumber: json['phone_number'],
      address: json['address'] ?? "Tidak disebutkan",
      firstOrder: json['first_order'] != null ? DateTime.parse(json['first_order']) : null,
      lastOrder: json['last_order'] != null ? DateTime.parse(json['last_order']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'phone_number': phoneNumber,
      'address': address,
      'first_order': firstOrder?.toIso8601String(),
      'last_order': lastOrder?.toIso8601String(),
    };
  }
}
