import 'package:app_laundry_bismillah/models/customer_model.dart';
import 'package:app_laundry_bismillah/models/laundry_item_model.dart';

class Transaction {
  final int id;
  final String invoice;
  final DateTime timestamp;
  final Customer customer;
  final List<LaundryItem> items;
  final LaundryService serviceType;
  final String status;
  final double totalHarga;

  Transaction({
    required this.id,
    required this.invoice,
    required this.timestamp,
    required this.customer,
    required this.items,
    required this.serviceType,
    required this.status,
    required this.totalHarga,
  });

  // Convert JSON dari API ke object Transaction
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: int.parse(json['id']),
      invoice: json['invoice'],
      timestamp: DateTime.parse(json['timestamp']),
      customer: Customer.fromJson(json['customer']),
      items: (json['items'] as List)
          .map((item) => LaundryItem.fromJson(item))
          .toList(),
      serviceType: LaundryService.values.byName(json['service_type']),
      status: json['status'],
      totalHarga: double.parse(json['total_harga']),
    );
  }

  // Convert object Transaction ke JSON buat dikirim ke API
  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'invoice': invoice,
      'timestamp': timestamp.toIso8601String(),
      'customer': customer.toJson(),
      'items': items.map((i) => i.toJson()).toList(),
      'service_type': serviceType.name,
      'status': status,
      'total_harga': totalHarga.toString(),
    };
  }
}
