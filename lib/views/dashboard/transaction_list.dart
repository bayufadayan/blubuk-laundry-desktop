// ignore_for_file: use_build_context_synchronously
import 'package:app_laundry_bismillah/views/dashboard/customer_info.dart';
import 'package:app_laundry_bismillah/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  late PlutoGridStateManager stateManager;
  List<PlutoRow> rows = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse('http://localhost:8080/blubuklaundry/getTransactionData.php'),
    );

    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          rows = List.generate(data.length, (index) {
            final transaction = data[index];
            return PlutoRow(cells: {
              'no': PlutoCell(value: (index + 1).toString()),
              'id': PlutoCell(value: transaction['id']?.toString() ?? ''),
              'invoice': PlutoCell(value: transaction['invoice'] ?? ''),
              'tanggal_order':
                  PlutoCell(value: transaction['tanggal_order'] ?? ''),
              'customer_name':
                  PlutoCell(value: transaction['customer_name'] ?? ''),
              'nomor_wa': PlutoCell(value: transaction['nomor_wa'] ?? ''),
              'item_laundry':
                  PlutoCell(value: transaction['item_laundry'] ?? ''),
              'total': PlutoCell(value: transaction['total'] ?? ''),
              'status_laundry':
                  PlutoCell(value: transaction['status_laundry'] ?? ''),
              'layanan': PlutoCell(value: transaction['layanan'] ?? ''),
              'tanggal_bayar': PlutoCell(
                  value: ((transaction['tanggal_bayar'] ==
                              "0000-00-00 00:00:00") ||
                          (transaction['tanggal_bayar'] == null))
                      ? '-'
                      : transaction['tanggal_bayar']),
              'status_bayar':
                  PlutoCell(value: transaction['status_bayar'] ?? ''),
            });
          });
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error parsing JSON: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data: ${response.statusCode}')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> updateTransaction(String id, String statusBayar) async {
    final response = await http.post(
      Uri.parse(
          'http://localhost:8080/blubuklaundry/updateTransactionPaidStatus.php'),
      body: {
        'id': id.toString(),
        'status_bayar': statusBayar,
      },
    );

    if (response.statusCode == 200) {
      // final result = json.decode(response.body);
      fetchData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text('Status Berhasil Diubah')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red, content: Text('Status Gagal Diubah')),
      );
    }
  }

  Future<void> updateTransactionLaundryStatus(
      String id, String statusLaundry) async {
    final response = await http.post(
      Uri.parse(
          'http://localhost:8080/blubuklaundry/updateTransactionLaundryStatus.php'),
      body: {
        'id': id.toString(),
        'status_laundry': statusLaundry,
      },
    );

    if (response.statusCode == 200) {
      // final result = json.decode(response.body);
      fetchData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text('Status Berhasil Diubah')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red, content: Text('Status Gagal Diubah')),
      );
    }
  }

  void launchWhatsApp(String nomor) async {
    final Uri url =
        Uri.parse("https://wa.me/${nomor.replaceAll(RegExp(r'^0'), '62')}");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "could not launch";
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<PlutoColumn> columns = [
      PlutoColumn(
          title: 'No',
          field: 'no',
          type: PlutoColumnType.text(),
          width: 60,
          textAlign: PlutoColumnTextAlign.center,
          enableEditingMode: false),
      PlutoColumn(
        title: 'Invoice',
        field: 'invoice',
        type: PlutoColumnType.text(),
        width: 100,
        enableEditingMode: false,
        enableRowDrag: true,
      ),
      PlutoColumn(
          title: 'Tanggal Order',
          field: 'tanggal_order',
          type: PlutoColumnType.text(),
          width: 142,
          enableEditingMode: false),
      PlutoColumn(
          title: 'Nama Customer',
          field: 'customer_name',
          type: PlutoColumnType.text(),
          width: 165,
          enableEditingMode: false),
      PlutoColumn(
        title: 'Nomor WA',
        field: 'nomor_wa',
        type: PlutoColumnType.text(),
        width: 120,
        enableEditingMode: false,
        renderer: (rendererContext) {
          final row = rendererContext.row;
          final phoneNumber = row.cells['nomor_wa']?.value;
          return SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      launchWhatsApp(phoneNumber);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 54, 185, 2),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      textStyle: TextStyle(fontSize: 14),
                    ),
                    child: Text(
                      phoneNumber,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
          title: 'Layanan',
          field: 'layanan',
          type: PlutoColumnType.text(),
          width: 100,
          enableEditingMode: false),
      PlutoColumn(
        title: 'Item Laundry',
        field: 'item_laundry',
        type: PlutoColumnType.text(),
        width: 133,
        enableEditingMode: false,
      ),
      PlutoColumn(
          title: 'Total',
          field: 'total',
          type: PlutoColumnType.text(),
          width: 95,
          enableEditingMode: false),
      PlutoColumn(
        title: 'Status Laundry',
        field: 'status_laundry',
        type: PlutoColumnType.text(),
        width: 138,
        enableEditingMode: false,
        renderer: (rendererContext) {
          final row = rendererContext.row;
          final statusLaundry = row.cells['status_laundry']?.value;
          return SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final transactionId = row.cells['id']?.value;
                      if (statusLaundry == "Dalam Antrian") {
                        updateTransactionLaundryStatus(
                            transactionId, "Cuci (Proses 1)");
                      } else if (statusLaundry == "Cuci (Proses 1)") {
                        updateTransactionLaundryStatus(
                            transactionId, "Setrika (Proses 2)");
                      } else if (statusLaundry == "Setrika (Proses 2)") {
                        updateTransactionLaundryStatus(
                            transactionId, "Siap Ambil");
                      } else if (statusLaundry == "Siap Ambil") {
                        updateTransactionLaundryStatus(
                            transactionId, "Transaksi Selesai");
                      } else {
                        updateTransactionLaundryStatus(
                            transactionId, "Dalam Antrian");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: statusLaundry != "Dalam Antrian"
                          ? statusLaundry != "Cuci (Proses 1)"
                              ? statusLaundry != "Setrika (Proses 2)"
                                  ? statusLaundry != "Siap Ambil"
                                      ? Colors.grey
                                      : Colors.green
                                  : Colors.purple
                              : Colors.blue
                          : Colors.orange,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      textStyle: TextStyle(fontSize: 14),
                    ),
                    child: Text(
                      statusLaundry,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
          title: 'Tanggal Bayar',
          field: 'tanggal_bayar',
          type: PlutoColumnType.text(),
          width: 140,
          enableEditingMode: false),
      PlutoColumn(
        title: 'Status Bayar',
        field: 'status_bayar',
        type: PlutoColumnType.text(),
        width: 130,
        enableEditingMode: false,
        renderer: (rendererContext) {
          final row = rendererContext.row;
          final statusBayar = row.cells['status_bayar']?.value;
          return SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final transactionId = row.cells['id']?.value;
                      if (statusBayar != "Lunas") {
                        updateTransaction(transactionId, "Lunas");
                      } else {
                        updateTransaction(transactionId, "Belum Lunas");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: statusBayar != "Lunas"
                          ? Color.fromARGB(255, 185, 14, 2)
                          : Color.fromARGB(255, 54, 185, 2),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      textStyle: TextStyle(fontSize: 14),
                    ),
                    child: Text(
                      statusBayar,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: MyAppBar(isGetBack: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Daftar Transaksi",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 32)),
            SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(
                minHeight: 42,
                maxWidth: 180,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomerInfo()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Buat Order Baru",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : PlutoGrid(
                      columns: columns,
                      rows: rows,
                      onLoaded: (PlutoGridOnLoadedEvent event) {
                        stateManager = event.stateManager;
                      },
                      configuration: PlutoGridConfiguration(
                        style: PlutoGridStyleConfig(
                          gridBorderColor: Colors.grey[300]!,
                          columnTextStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          cellTextStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
