// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'dart:convert';
import 'package:app_laundry_bismillah/utils/config.dart';
import 'package:app_laundry_bismillah/views/dashboard/new_order.dart';
import 'package:app_laundry_bismillah/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class CustomerInfo extends StatefulWidget {
  const CustomerInfo({super.key});

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  List<Map<String, dynamic>> customers = [];
  String? selectedCustomerId;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isNewCustomer = true;
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    try {
      var response = await http.get(
          Uri.parse('${AppConfig.baseUrl}/getCustomerData.php'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          customers = List<Map<String, dynamic>>.from(data);
        });
      }
    } catch (e) {
      // print('Error fetching customers: $e');
    }
  }

  Future<String?> createCustomer(BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/addCustomerData.php'),
        body: {
          'name': nameController.text,
          'phone_number': phoneController.text,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // print("ini data: $data");
        if (data['status'] == 'error') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
              backgroundColor: Colors.red,
            ),
          );
          return null;
        }
        return data['data']['id'].toString();
      }
    } catch (e) {
      // print('Error creating customer: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat membuat customer.'),
          backgroundColor: Colors.red,
        ),
      );
    }
    return null;
  }

  void onNextPressed() async {
    String? customerId = selectedCustomerId;
    String? customerName = nameController.text;
    String? customerPhone = phoneController.text;

    if (isNewCustomer) {
      customerId = await createCustomer(context);
    }
    if (customerId != null && customerId.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewOrder(
            customerId: customerId!,
            customerName: customerName,
            customerPhone: customerPhone,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: customerId is null or empty'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app Bar
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 430,
                height: 460,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: Color.fromARGB(255, 29, 29, 31), width: 6.0),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: const <Color>[
                        Color.fromRGBO(255, 255, 255, 1),
                        Color.fromRGBO(151, 159, 228, 1),
                      ]),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 16)),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(children: <Widget>[
                            Text('Customer',
                                style: GoogleFonts.neucha(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w700,
                                    textStyle: TextStyle(letterSpacing: 5.0))),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: Text(
                                'Silakan pilih customer atau isi kolom untuk menambah customer baru',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  'Masukan Nama/No Telp dan Pilih Customers',
                                  style: GoogleFonts.roboto(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left),
                            ),
                            Padding(padding: EdgeInsets.only(top: 3.7)),
                            Container(
                                alignment: Alignment.topLeft,
                                width: double.infinity,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    DropdownSearch<String>(
                                      popupProps: PopupProps.menu(
                                        showSearchBox: true,
                                        menuProps: MenuProps(
                                          backgroundColor: Colors.grey[200],
                                        ),
                                      ),
                                      items: (String filter,
                                          LoadProps? props) async {
                                        return customers
                                            .map((c) =>
                                                "${c['name']} - ${c['phone_number']}")
                                            .where((item) => item
                                                .toLowerCase()
                                                .contains(filter.toLowerCase()))
                                            .toList();
                                      },
                                      dropdownBuilder: (context, selectedItem) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              selectedItem ??
                                                  "Pilih/Cari Nama atau No.Telp",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: selectedItem != null
                                                    ? Colors.blue.shade800
                                                    : Colors.grey,
                                              ),
                                            ),
                                            if (selectedItem != null)
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.red.withOpacity(
                                                      0.2), // Transparan soft
                                                  shape: BoxShape.circle,
                                                ),
                                                child: IconButton(
                                                  icon: Icon(Icons.clear,
                                                      color: Colors.red,
                                                      size: 18),
                                                  splashRadius: 18,
                                                  padding: EdgeInsets.zero,
                                                  constraints: BoxConstraints(),
                                                  onPressed: () {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Kolom sudah dikosongkan, Silakan isi customer baru'),
                                                      ),
                                                    );
                                                    setState(() {
                                                      this.selectedItem = null;
                                                      selectedCustomerId = null;
                                                      nameController.clear();
                                                      phoneController.clear();
                                                      isNewCustomer = true;
                                                    });
                                                  },
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                      onChanged: (value) {
                                        if (value != null) {
                                          var selected = customers.firstWhere(
                                            (c) =>
                                                "${c['name']} - ${c['phone_number']}" ==
                                                value,
                                            orElse: () => {},
                                          );
                                          if (selected.isNotEmpty) {
                                            setState(() {
                                              selectedCustomerId =
                                                  selected['id'].toString();
                                              nameController.text =
                                                  selected['name'];
                                              phoneController.text =
                                                  selected['phone_number'];
                                              isNewCustomer = false;
                                              selectedItem = value;
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            selectedCustomerId = null;
                                            nameController.clear();
                                            phoneController.clear();
                                            isNewCustomer = true;
                                            selectedItem = null;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Divider(
                                thickness: 1.4,
                                color: const Color.fromARGB(255, 126, 126, 126),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text('Nama Customers',
                                  style: GoogleFonts.roboto(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left),
                            ),
                            Padding(padding: EdgeInsets.only(top: 3.7)),
                            Container(
                              alignment: Alignment.topLeft,
                              width: double.infinity,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                  controller: nameController,
                                  enabled: isNewCustomer,
                                  keyboardType: TextInputType.name,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 1, 32, 44),
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: 'Masukan Nama Customers',
                                    hintStyle: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                            ),
                            Padding(padding: EdgeInsets.only(top: 9)),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text('Nomor WhatsApp',
                                  style: GoogleFonts.roboto(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left),
                            ),
                            Padding(padding: EdgeInsets.only(top: 3.7)),
                            Container(
                              alignment: Alignment.topLeft,
                              width: double.infinity,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                  controller: phoneController,
                                  enabled: isNewCustomer,
                                  keyboardType: TextInputType.phone,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 1, 32, 44),
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: 'Masukan Nomor WhatsApp',
                                    hintStyle: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 68, 113, 212),
                                  minimumSize: Size(double.infinity, 60),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: onNextPressed,
                                child: Text("Next"),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
