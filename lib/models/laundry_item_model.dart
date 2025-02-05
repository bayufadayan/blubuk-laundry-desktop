enum LaundryService { express, regular }

enum LaundryCategory { satuan, kiloan }

abstract class LaundryItem {
  final int id;
  final String name;
  final LaundryCategory category;
  final double hargaReguler;
  final double hargaExpress;

  LaundryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.hargaReguler,
    required this.hargaExpress,
  });

  factory LaundryItem.fromJson(Map<String, dynamic> json) {
    return json['category'] == "satuan"
        ? SatuanLaundry.fromJson(json)
        : KiloanLaundry.fromJson(json);
  }

  Map<String, dynamic> toJson();
}

class SatuanLaundry extends LaundryItem {
  SatuanLaundry({
    required super.id,
    required super.name,
    required super.hargaReguler,
    required super.hargaExpress,
  }) : super(
          category: LaundryCategory.satuan,
        );

  factory SatuanLaundry.fromJson(Map<String, dynamic> json) {
    return SatuanLaundry(
      id: int.parse(json['id']),
      name: json['name'],
      hargaReguler: double.parse(json['harga_reguler']),
      hargaExpress: double.parse(json['harga_express']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'category': 'satuan',
      'harga_reguler': hargaReguler.toString(),
      'harga_express': hargaExpress.toString(),
    };
  }
}

class KiloanLaundry extends LaundryItem {
  KiloanLaundry({
    required super.id,
    required super.hargaReguler,
    required super.hargaExpress,
  }) : super(
          name: "Kiloan",
          category: LaundryCategory.kiloan,
        );

  factory KiloanLaundry.fromJson(Map<String, dynamic> json) {
    return KiloanLaundry(
      id: int.parse(json['id']),
      hargaReguler: double.parse(json['harga_reguler']),
      hargaExpress: double.parse(json['harga_express']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'name': 'Kiloan',
      'category': 'kiloan',
      'harga_reguler': hargaReguler.toString(),
      'harga_express': hargaExpress.toString(),
    };
  }
}
