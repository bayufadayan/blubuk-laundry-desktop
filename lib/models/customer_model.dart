import 'person_model.dart';

class Customer extends Person {
  final int id;
  DateTime? firstOrder;
  DateTime? lastOrder;

  Customer({
    required this.id,
    required super.name,
    required super.phoneNumber,
    this.firstOrder,
    this.lastOrder,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: int.parse(json['id']),
      name: json['name'],
      phoneNumber: json['phone_number'],
      firstOrder: json['first_order'] != null ? DateTime.parse(json['first_order']) : null,
      lastOrder: json['last_order'] != null ? DateTime.parse(json['last_order']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'phone_number': phoneNumber,
      'first_order': firstOrder?.toIso8601String(),
      'last_order': lastOrder?.toIso8601String(),
    };
  }
}
