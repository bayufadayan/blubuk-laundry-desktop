import 'person_model.dart';

class Admin extends Person {
  final int id;
  final String email;
  final String password;
  final String address;

  Admin({
    required this.id,
    required super.name,
    required super.phoneNumber,
    required this.email,
    required this.password,
    required this.address,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: int.parse(json['id']),
      name: json['name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'password': password,
      'address': address,
    };
  }
}
