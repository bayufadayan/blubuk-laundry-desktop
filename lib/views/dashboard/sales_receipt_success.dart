import 'package:app_laundry_bismillah/views/dashboard/customer_info.dart';
import 'package:app_laundry_bismillah/views/dashboard/dashboard.dart';
import 'package:app_laundry_bismillah/views/dashboard/transaction_list.dart';
import 'package:app_laundry_bismillah/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher.dart';

class SalesReceiptSuccess extends StatelessWidget {
  final String invoice;
  final String customerName;
  final String nomorWa;
  final String layanan;
  final String statusLaundry;
  final int totalTagihan;
  final String statusBayar;
  final List<Map<String, dynamic>> itemLaundry;

  const SalesReceiptSuccess({
    super.key,
    required this.invoice,
    required this.customerName,
    required this.nomorWa,
    required this.layanan,
    required this.statusLaundry,
    required this.totalTagihan,
    required this.statusBayar,
    required this.itemLaundry,
  });

  void launchWhatsApp({
    required String nomorWa,
    required String invoice,
    required String customerName,
    required String layanan,
    required String statusLaundry,
    required int totalTagihan,
    required String statusBayar,
    required List<Map<String, dynamic>> itemLaundry,
  }) async {
    String formattedNumber = nomorWa.replaceAll(RegExp(r'^0'), '62');
    await initializeDateFormatting('id_ID', null);
    String formattedDate =
        DateFormat('EEEE, d MMM yyyy HH:mm:ss', 'id_ID').format(DateTime.now());

    String items = itemLaundry.map((item) {
      return "- ${item['item_name']} -- ${item['qty']} [Rp. ${NumberFormat('#,###').format(int.parse(item['total_harga_item']))}]";
    }).join("%0A");

    // Template pesan WA
    String message = "*Blubuk Laundry*%0A"
        "+-----------------------+%0A"
        "Terima kasih telah mencuci disini 🤗%0A%0A"
        "Berikut Detail Order atas Nama:%0A"
        "*Nama* : $customerName%0A"
        "*No Telp* : $nomorWa%0A"
        "=========================%0A"
        "*Hari/Tanggal* : $formattedDate%0A"
        "*Invoice* : $invoice%0A"
        "*Layanan* : $layanan%0A"
        "*Status Laundry* : $statusLaundry%0A"
        "*Status Bayar* : $statusBayar%0A"
        "*Total Bayar* : Rp. ${NumberFormat('#,###').format(totalTagihan)}%0A%0A"
        "========================%0A"
        "*Detail item Laundry:*%0A"
        "$items%0A"
        "========================%0A%0A"
        "Terima Kasih. Jangan lupa datang kembali yaa! 😊";

    // Encode URL
    String url = "https://wa.me/$formattedNumber?text=$message";

    // Buka WhatsApp
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch WhatsApp";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 238, 251),
      appBar: MyAppBar(isGetBack: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            constraints: BoxConstraints(maxWidth: 800),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, size: 30, color: Colors.green,),
                        SizedBox(width: 10),
                        Center(
                          child: Text(
                            "Transaksi Berhasil!",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerInfo()),
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        size: 14,
                      ),
                      label: Text("Buat Orderan Baru"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade600,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        textStyle: TextStyle(fontSize: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildDetailSection(),
                SizedBox(height: 20),
                _buildItemList(),
                SizedBox(height: 20),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard()),
                        );
                      },
                      icon: Icon(Icons.home),
                      label: Text("Dashboard"),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionList()),
                        );
                      },
                      icon: Icon(Icons.list),
                      label: Text("Daftar Transaksi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        launchWhatsApp(
                          nomorWa: nomorWa,
                          invoice: invoice,
                          customerName: customerName,
                          layanan: layanan,
                          statusLaundry: statusLaundry,
                          totalTagihan: totalTagihan,
                          statusBayar: statusBayar,
                          itemLaundry: itemLaundry
                              .map((item) => {
                                    "item_name": item['item_name'],
                                    "qty": item['qty'],
                                    "total_harga_item":
                                        item['total_harga_item'],
                                  })
                              .toList(),
                        );
                      },
                      icon: Icon(Icons.send),
                      label: Text("Kirim WhatsApp"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Detail Pelanggan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  invoice,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[900]),
                ),
              ],
            ),
            Divider(),
            _buildDetailRow("Nama", customerName),
            _buildDetailRow("Nomor WA", nomorWa),
            _buildDetailRow("Layanan", layanan),
            _buildDetailRow("Status Laundry", statusLaundry),
            _buildDetailRow(
              "Total Tagihan",
              "Rp ${NumberFormat('#,###').format(totalTagihan)}",
              isBold: true,
              color: Colors.blue,
            ),
            _buildDetailRow("Status Bayar", statusBayar),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value,
      {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Detail Item Laundry (${itemLaundry.length})",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemLaundry.length,
              itemBuilder: (context, index) {
                final item = itemLaundry[index];
                return ListTile(
                  title: Text(
                    item['item_name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Qty: ${item['qty']}'),
                  trailing: Text(
                    'Rp. ${NumberFormat('#,###').format(int.parse(item['total_harga_item']))}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
