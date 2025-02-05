// ignore_for_file: use_build_context_synchronously

import 'package:app_laundry_bismillah/views/dashboard/admin_add_new.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class AdminList extends StatefulWidget {
  const AdminList({super.key});

  @override
  State<AdminList> createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
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
      Uri.parse('http://localhost:8080/blubuklaundry/getAdminData.php'),
    );

    // print('Response: ${response.body}');

    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = json.decode(response.body);
        // print('Parsed Data: $data');

        setState(() {
          rows = List.generate(data.length, (index) {
            final admin = data[index];
            return PlutoRow(cells: {
              'no': PlutoCell(value: (index + 1).toString()),
              'id': PlutoCell(value: admin['id']?.toString() ?? ''),
              'nama': PlutoCell(value: admin['name'] ?? ''),
              'phone': PlutoCell(value: admin['phone_number'] ?? ''),
              'email': PlutoCell(value: admin['email'] ?? ''),
              'alamat': PlutoCell(value: admin['address'] ?? ''),
              'aksi': PlutoCell(value: ''),
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

  Future<void> updateData(int id, Map<String, String> updatedData) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/blubuklaundry/updateAdminData.php'),
      body: {
        'id': id.toString(),
        ...updatedData,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil diperbarui')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui data')),
      );
    }
  }

  Future<void> deleteData(String id) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/blubuklaundry/deleteAdminData.php'),
      body: {'id': id},
    );

    final result = json.decode(response.body);
    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );

      fetchData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menghapus data: ${result['message']}")),
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
        width: 67,
        titleTextAlign: PlutoColumnTextAlign.center,
        textAlign: PlutoColumnTextAlign.center,
        enableEditingMode: false,
      ),
      PlutoColumn(
        title: 'Nama Lengkap',
        field: 'nama',
        type: PlutoColumnType.text(),
        width: 250,
      ),
      PlutoColumn(
        title: 'Phone Number',
        field: 'phone',
        type: PlutoColumnType.text(),
        width: 155,
      ),
      PlutoColumn(
        title: 'Email',
        field: 'email',
        type: PlutoColumnType.text(),
        width: 250,
      ),
      PlutoColumn(
        title: 'Alamat',
        field: 'alamat',
        type: PlutoColumnType.text(),
        width: 350,
      ),
      PlutoColumn(
        title: 'Aksi',
        field: 'aksi',
        type: PlutoColumnType.text(),
        width: 250,
        enableEditingMode: false,
        renderer: (rendererContext) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  final row = rendererContext.row;
                  final id = row.cells['id']?.value.toString() ?? '';

                  if (id.isNotEmpty) {
                    deleteData(id);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Id Tidak ditemukan')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 33, 33),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: TextStyle(fontSize: 14),
                ),
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  final row = rendererContext.row;
                  launchWhatsApp(row.cells['phone']?.value);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 54, 185, 2),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: TextStyle(fontSize: 14),
                ),
                child: Text(
                  'Contact',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Admin"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Daftar Admin",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(
                minHeight: 42,
                maxWidth: 200,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminAddNew()),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Tambah Admin Baru",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : PlutoGrid(
                      columns: columns,
                      rows: rows,
                      onLoaded: (PlutoGridOnLoadedEvent event) {
                        stateManager = event.stateManager;
                      },
                      onChanged: (PlutoGridOnChangedEvent event) {
                        final row = event.row;
                        final updatedData = {
                          'name': row.cells['nama']?.value?.toString() ?? '',
                          'phone_number':
                              row.cells['phone']?.value?.toString() ?? '',
                          'email': row.cells['email']?.value?.toString() ?? '',
                          'address':
                              row.cells['alamat']?.value?.toString() ?? '',
                        };

                        final noValue = row.cells['no']?.value;
                        if (noValue != null) {
                          updateData(
                              int.parse(noValue.toString()), updatedData);
                        }
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
