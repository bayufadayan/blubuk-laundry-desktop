// ignore_for_file: unused_import, prefer_const_constructors, use_build_context_synchronously
import 'dart:convert';
import 'package:app_laundry_bismillah/utils/config.dart';
import 'package:app_laundry_bismillah/views/dashboard/customer_info.dart';
import 'package:app_laundry_bismillah/views/dashboard/history.dart';
import 'package:app_laundry_bismillah/views/dashboard/sales_receipt_success.dart';
import 'package:app_laundry_bismillah/widgets/myappbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_laundry_bismillah/main.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:core';

String generateInvoice() {
  final now = DateTime.now();
  final random = Random();
  final letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  return '${letters[random.nextInt(letters.length)]}${letters[random.nextInt(letters.length)]}-${now.millisecondsSinceEpoch.toString().substring(6)}';
}

class NewOrder extends StatefulWidget {
  final String customerId;
  final String customerName;
  final String customerPhone;

  const NewOrder({
    super.key,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
  });

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final timeNow = DateTime.now();
  TextEditingController timeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  final String invoice = generateInvoice();
  String service = "Regular";
  List<Map<String, dynamic>> itemCategory = [];
  List<Map<String, dynamic>> itemLaundry = [];
  String? selectedItemCategoryId;
  int? transactionId;
  int subTotalItem = 0;
  int hargaPokok = 0;
  int totalTagihan = 0;
  // buat item terpilih di dropdown
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    createTransaction(context);
    fetchItemCategory();
    timeController.text = DateTime.now().toString();
  }

  // void addData() {
  //   var url = "${AppConfig.baseUrl}/adddata.php";

  //   http.post(Uri.parse(url), body: {
  //     "waktu": timeController.text,
  //     "tanggal": serviceController.text,
  //     "metodeambil": controllerMetodeAmbil.text,
  //     "jenislayanan": controllerJenisLayanan.text,
  //     "jenisbahan": controllerJenisBahan.text,
  //     "berat": weightController.text,
  //     "hargapokok": controllerHargaPokok.text,
  //   });
  // }

  Future<void> createTransaction(BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse(
            '${AppConfig.baseUrl}/addBlankTransaction.php'),
        body: {
          'invoice': invoice,
          'id_customer': widget.customerId,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'error') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        setState(() {
          transactionId = int.parse(data['data']['id'].toString());
        });
        fetchItemLaundry(int.parse(widget.customerId), transactionId!);
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
    return;
  }

  Future<void> fetchItemCategory() async {
    try {
      var response = await http.get(
          Uri.parse('${AppConfig.baseUrl}/getItemCategory.php'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          itemCategory = List<Map<String, dynamic>>.from(data);
        });
      }
    } catch (e) {
      // print('Error fetching itemCategory: $e');
    }
  }

  Future<void> fetchItemLaundry(int idCustomer, int idTransaction) async {
    try {
      var response = await http.post(
        Uri.parse(
            '${AppConfig.baseUrl}/getItemLaundrybyTransaction.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'id_customer': idCustomer.toString(),
          'id_transaction': idTransaction.toString(),
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          totalTagihan = 0;
        });
        for (var item in data) {
          setState(() {
            totalTagihan +=
                double.parse(item['total_harga_item'].toString()).floor();
          });
        }
        setState(() {
          itemLaundry = List<Map<String, dynamic>>.from(data);
        });
      } else {}
    } catch (e) {
      // print('Error fetching item laundry: $e');
    }
  }

  // fungsi add item laundry
  Future<void> createItemLaundry(BuildContext context) async {
    try {
      if (weightController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Kolom berat/qty wajib diisi"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      var response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/addItemLaundry.php'),
        body: {
          'id_customer': widget.customerId,
          'id_item_category': selectedItemCategoryId,
          'id_transaction': transactionId.toString(),
          'berat_qty': weightController.text,
          'total_harga_item': subTotalItem.toString(),
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        int itemLaundryId = int.parse(data['id_item_category'].toString());
        // print("${transactionId!} + ${itemLaundryId} + ${subTotalItem}");
        createTransactionDetail(transactionId!, itemLaundryId, subTotalItem);
        if (data['status'] == 'error') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('terjadi kesalahan saat membuat item (${e.toString()})'),
          backgroundColor: Colors.red,
        ),
      );
    }
    return;
  }

  Future<void> createTransactionDetail(
      int idTransaksi, int idItemLaundry, int totalBayar) async {
    try {
      var response = await http.post(
        Uri.parse(
            '${AppConfig.baseUrl}/addTransactionDetail.php'),
        body: {
          'id_transaksi': idTransaksi.toString(),
          'id_item_laundry': idItemLaundry.toString(),
          'total_bayar': totalBayar.toString(),
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        fetchItemLaundry(int.parse(widget.customerId), transactionId!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Item Berhasil diTambahkan"),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          weightController.clear();
          subTotalItem = 0;
          hargaPokok = 0;
        });
        if (data['status'] == 'error') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Terjadi kesalahan saat membuat detail transaksi ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
    return;
  }

  Future<void> deleteItemLaundry(String id) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}/deleteItemLaundry.php'),
      body: {'id': id},
    );

    final result = json.decode(response.body);
    if (result['success']) {
      deleteTransactionDetail(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );

      fetchItemLaundry(int.parse(widget.customerId), transactionId!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menghapus data: ${result['message']}")),
      );
    }
  }

  Future<void> deleteTransactionDetail(String id) async {
    final response = await http.post(
      Uri.parse(
          '${AppConfig.baseUrl}/deleteTransactionDetail.php'),
      body: {'id': id},
    );

    final result = json.decode(response.body);
    if (result['success']) {
      fetchItemLaundry(int.parse(widget.customerId), transactionId!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menghapus data: ${result['message']}")),
      );
    }
  }

  Future<void> updateTransaction(String id, String layanan) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}/updateTransaction.php'),
      body: {
        'id': id,
        'layanan': layanan,
        'total_tagihan': totalTagihan.toString(),
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transaksi Berhasil Dilakukan')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal melakukan transaksi')),
      );
    }
  }

  void onAddLaundryItemPressed() async {
    if (transactionId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Terjadi Kesalahan, Transaksi Null'),
      ));
    } else {
      createItemLaundry(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(isGetBack: true),
      body: Stack(
        children: <Widget>[
          //bg
          Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(colors: const <Color>[
              Color.fromRGBO(252, 254, 252, 1),
              Color.fromARGB(255, 252, 239, 249),
            ])),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "images/second_pattern.png",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buat Order Baru',
                    style: GoogleFonts.openSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        textStyle: TextStyle(letterSpacing: 1.0)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        width: 280,
                        height: 520,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Informasi Customer",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(height: 8),
                            Divider(thickness: 1, color: Colors.grey[300]),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Invoice:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                  invoice,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Nama:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                  widget.customerName,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("No. Telp:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                  widget.customerPhone,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          // width: 900,
                          // height: 475,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Color.fromRGBO(71, 71, 102, 1),
                                width: 0.0),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: const <Color>[
                                  Color.fromARGB(255, 248, 232, 246),
                                  Color.fromARGB(255, 219, 222, 241),
                                  Color.fromARGB(255, 181, 186, 214),
                                  Color.fromARGB(255, 149, 158, 211),
                                ]),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Detail Transaksi",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Divider(thickness: 1, color: Colors.black),
                                SizedBox(height: 8),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 6,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    width: 175,
                                                    height: 50,
                                                    // height: 38,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: TextField(
                                                      controller:
                                                          timeController,
                                                      enabled: false,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors
                                                              .blue.shade900),
                                                      decoration:
                                                          InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        label: Text(
                                                          "Waktu",
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .blue),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .blue),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .blue),
                                                        ),
                                                        hintStyle:
                                                            GoogleFonts.roboto(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    width: 200,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child:
                                                        DropdownButtonFormField<
                                                            String>(
                                                      value: "Regular",
                                                      items: [
                                                        "Regular",
                                                        "Express"
                                                      ].map((String item) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(item,
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        1,
                                                                        32,
                                                                        44),
                                                              )),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        // Handle perubahan pilihan
                                                        setState(() {
                                                          service = value ??
                                                              "Regular";
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        label: Text(
                                                            "Pilihan Layanan"),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .blue),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .blue),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .blue),
                                                        ),
                                                        hintText:
                                                            "Regular / Express",
                                                        hintStyle:
                                                            GoogleFonts.roboto(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Total Tagihan',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey[700],
                                                    ),
                                                  ),
                                                  Text(
                                                    "Rp ${NumberFormat('#,###').format(totalTagihan)}",
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Silakan Input Item Laundry',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.purple.shade700),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),

                                          // ini column buat nambah item
                                          SizedBox(
                                            height: 225,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 300,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white60,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: DropdownSearch<
                                                            String>(
                                                          popupProps:
                                                              PopupProps.menu(
                                                            showSearchBox: true,
                                                            menuProps:
                                                                MenuProps(
                                                              backgroundColor:
                                                                  Colors.grey[
                                                                      200],
                                                            ),
                                                          ),
                                                          items: (String filter,
                                                              LoadProps?
                                                                  props) async {
                                                            return itemCategory
                                                                .map((c) =>
                                                                    "${c['nama']} - ${c['harga']}")
                                                                .where((item) => item
                                                                    .toLowerCase()
                                                                    .contains(filter
                                                                        .toLowerCase()))
                                                                .toList();
                                                          },
                                                          dropdownBuilder:
                                                              (context,
                                                                  selectedItem) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  selectedItem ??
                                                                      "Pilih Item",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: selectedItem !=
                                                                            null
                                                                        ? Colors
                                                                            .blue
                                                                            .shade800
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                ),
                                                                if (selectedItem !=
                                                                    null)
                                                                  Container(
                                                                    width: 30,
                                                                    height: 30,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.2), // Transparan soft
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child:
                                                                        IconButton(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .clear,
                                                                          color: Colors
                                                                              .red,
                                                                          size:
                                                                              18),
                                                                      splashRadius:
                                                                          18,
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      constraints:
                                                                          BoxConstraints(),
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          this.selectedItem =
                                                                              null;
                                                                          selectedItemCategoryId =
                                                                              null;
                                                                          weightController
                                                                              .clear();
                                                                          subTotalItem =
                                                                              0;
                                                                          hargaPokok =
                                                                              0;
                                                                        });
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text('Kolom sudah dikosongkan!'),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                              ],
                                                            );
                                                          },
                                                          onChanged: (value) {
                                                            if (value != null) {
                                                              var selected =
                                                                  itemCategory
                                                                      .firstWhere(
                                                                (c) =>
                                                                    "${c['nama']} - ${c['harga']}" ==
                                                                    value,
                                                                orElse: () =>
                                                                    {},
                                                              );
                                                              if (selected
                                                                  .isNotEmpty) {
                                                                setState(() {
                                                                  selectedItemCategoryId =
                                                                      selected[
                                                                              'id']
                                                                          .toString();
                                                                  hargaPokok =
                                                                      int.parse(
                                                                          selected[
                                                                              'harga']);
                                                                  if (weightController
                                                                      .text
                                                                      .isEmpty) {
                                                                    subTotalItem =
                                                                        0;
                                                                  } else {
                                                                    subTotalItem =
                                                                        (double.parse(selected['harga']) *
                                                                                double.parse(weightController.text))
                                                                            .floor();
                                                                  }

                                                                  selectedItem =
                                                                      value;
                                                                });
                                                              }
                                                            } else {
                                                              setState(() {
                                                                selectedItemCategoryId =
                                                                    null;
                                                                weightController
                                                                    .clear();
                                                                subTotalItem =
                                                                    0;
                                                                hargaPokok = 0;
                                                                selectedItem =
                                                                    null;
                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),

                                                      // Input Berat/Qty
                                                      Container(
                                                        width: 100,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white60,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: TextField(
                                                          controller:
                                                              weightController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .numberWithOptions(
                                                                      decimal:
                                                                          true),
                                                          style: GoogleFonts
                                                              .roboto(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    1,
                                                                    32,
                                                                    44),
                                                          ),
                                                          onChanged: (value) {
                                                            // Validasi input untuk memastikan hanya angka yang diterima
                                                            if (value
                                                                .isNotEmpty) {
                                                              if (double.tryParse(
                                                                      value) !=
                                                                  null) {
                                                                double harga =
                                                                    double.parse(
                                                                        hargaPokok
                                                                            .toString());
                                                                double weight =
                                                                    double.parse(
                                                                        value);
                                                                setState(() {
                                                                  subTotalItem =
                                                                      (harga *
                                                                              weight)
                                                                          .floor();
                                                                });
                                                              } else {
                                                                // print(
                                                                //     "Input tidak valid, hanya angka yang diperbolehkan.");
                                                              }
                                                            } else {
                                                              setState(() {
                                                                subTotalItem =
                                                                    0;
                                                              });
                                                            }
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            labelText:
                                                                'Berat/Qty (Kg)',
                                                            hintText:
                                                                'Masukkan jumlah',
                                                            labelStyle:
                                                                GoogleFonts
                                                                    .roboto(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .roboto(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Container(
                                                        width: 150,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white60,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: TextField(
                                                          enabled: false,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: GoogleFonts
                                                              .roboto(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    1,
                                                                    32,
                                                                    44),
                                                          ),
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            labelText:
                                                                "Rp. ${hargaPokok.toString()}",
                                                            hintText:
                                                                'Harga Satuan',
                                                            labelStyle:
                                                                GoogleFonts
                                                                    .roboto(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .roboto(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),

                                                      // Total Harga
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Sub Total Item",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Rp ${NumberFormat('#,###').format(subTotalItem)}",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 60),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          onAddLaundryItemPressed();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.green,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16.0,
                                                                  vertical:
                                                                      16.0),
                                                          elevation: 2,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(Icons.add,
                                                                color: Colors
                                                                    .white),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "Tambah Item Laundry",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),

                                                // list item yang mau dilaundry
                                                Container(
                                                  height: 165,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                      )),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        itemLaundry.isEmpty
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10.0),
                                                                child: Center(
                                                                    child: Text(
                                                                        "Belum ada item laundry")),
                                                              )
                                                            : Table(
                                                                border: TableBorder
                                                                    .symmetric(
                                                                  inside: BorderSide(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                columnWidths: {
                                                                  0: FixedColumnWidth(
                                                                      30),
                                                                  1: FlexColumnWidth(),
                                                                  2: FixedColumnWidth(
                                                                      130),
                                                                  3: FixedColumnWidth(
                                                                      130),
                                                                  4: FixedColumnWidth(
                                                                      150),
                                                                },
                                                                children: [
                                                                  _buildTableRow([
                                                                    "#",
                                                                    "Item",
                                                                    "Qty/Berat",
                                                                    "Harga",
                                                                    "Aksi"
                                                                  ],
                                                                      isHeader:
                                                                          true),
                                                                  ...itemLaundry
                                                                      .asMap()
                                                                      .entries
                                                                      .map(
                                                                          (entry) {
                                                                    int index =
                                                                        entry
                                                                            .key;
                                                                    Map<String,
                                                                            dynamic>
                                                                        item =
                                                                        entry
                                                                            .value;

                                                                    return _buildTableRow([
                                                                      (index +
                                                                              1)
                                                                          .toString(),
                                                                      item[
                                                                          'item_name'],
                                                                      item[
                                                                          'qty'],
                                                                      "Rp ${NumberFormat('#,###').format(int.parse(item['total_harga_item']))}",
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          deleteItemLaundry(
                                                                              item['id'].toString());
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                          foregroundColor:
                                                                              Colors.white,
                                                                        ),
                                                                        child: Text(
                                                                            "Delete"),
                                                                      ),
                                                                    ]);
                                                                  }),
                                                                  // }).toList(),
                                                                ],
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                                255, 68, 113, 212),
                                            minimumSize:
                                                Size(double.infinity, 60),
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () {
                                            // Memanggil fungsi untuk memperbarui transaksi
                                            updateTransaction(
                                                transactionId!.toString(),
                                                service);

                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SalesReceiptSuccess(
                                                  invoice: invoice,
                                                  customerName:
                                                      widget.customerName,
                                                  nomorWa: widget.customerPhone,
                                                  layanan: service,
                                                  statusLaundry:
                                                      "Dalam Antrian",
                                                  totalTagihan: totalTagihan,
                                                  statusBayar: "Belum Lunas",
                                                  itemLaundry: itemLaundry,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text("Next"),
                                        ),
                                      ),
                                    ]),
                              ]),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

TableRow _buildTableRow(List<dynamic> cells, {bool isHeader = false}) {
  return TableRow(
    decoration:
        BoxDecoration(color: isHeader ? Colors.grey[300] : Colors.transparent),
    children: cells.map((cell) {
      if (cell is ElevatedButton) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: cell,
        );
      } else {
        String displayText = cell != null ? cell.toString() : '';
        return Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            displayText,
            style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
          ),
        );
      }
    }).toList(),
  );
}
