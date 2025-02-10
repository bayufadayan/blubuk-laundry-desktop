// ignore_for_file: use_build_context_synchronously
import 'package:app_laundry_bismillah/utils/config.dart';
import 'package:app_laundry_bismillah/views/dashboard/customer_info.dart';
import 'package:app_laundry_bismillah/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
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
      Uri.parse('${AppConfig.baseUrl}/getCustomerData.php'),
    );

    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          rows = List.generate(data.length, (index) {
            final customer = data[index];
            return PlutoRow(cells: {
              'no': PlutoCell(value: (index + 1).toString()),
              'id': PlutoCell(value: customer['id']?.toString() ?? ''),
              'nama': PlutoCell(value: customer['name'] ?? ''),
              'phone_number': PlutoCell(value: customer['phone_number'] ?? ''),
              'first_order': PlutoCell(value: customer['first_order'] ?? ''),
              'last_order': PlutoCell(value: customer['last_order'] ?? ''),
              'total_transactions':
                  PlutoCell(value: customer['total_transactions'] ?? ''),
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
          width: 70,
          textAlign: PlutoColumnTextAlign.center,
          enableEditingMode: false),
      PlutoColumn(
          title: 'Nama Customer',
          field: 'nama',
          type: PlutoColumnType.text(),
          width: 500,
          enableEditingMode: false,
          enableRowDrag: true),
      PlutoColumn(
        title: 'Nomor WA',
        field: 'phone_number',
        type: PlutoColumnType.text(),
        width: 200,
        enableEditingMode: false,
        textAlign: PlutoColumnTextAlign.left,
        renderer: (rendererContext) {
          final row = rendererContext.row;
          final phoneNumber = row.cells['phone_number']?.value;
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
          title: 'Transaksi Pertama',
          field: 'first_order',
          type: PlutoColumnType.text(),
          width: 185,
          enableEditingMode: false),
      PlutoColumn(
          title: 'Transaksi Terakhir',
          field: 'last_order',
          type: PlutoColumnType.text(),
          width: 185,
          enableEditingMode: false),
      PlutoColumn(
        title: 'Jumlah Transaksi',
        field: 'total_transactions',
        type: PlutoColumnType.text(),
        width: 180,
        enableEditingMode: false,
        textAlign: PlutoColumnTextAlign.center
      ),
    ];

    return Scaffold(
      appBar: MyAppBar(isGetBack: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Daftar Customer",
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
