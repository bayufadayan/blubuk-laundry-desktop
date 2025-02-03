abstract class Person {
  String? nama;
  String? noTelp;
}

class Admin extends Person {
  String? username;
  // ignore: unused_field
  String? _password;
  String? jenjang;
}

class Customers extends Person {
  String? alamat;
}

class Transaksi {
  String? waktu;
  String? tanggal;
  String? metodePengambilan;
  String? jenisPelayanan;

  String? jenisBahan;
  String? berat;
}
