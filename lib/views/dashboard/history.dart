// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';
import 'package:app_laundry_bismillah/views/dashboard/customer_info.dart';
import 'package:app_laundry_bismillah/views/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:app_laundry_bismillah/main.dart';

class History extends StatelessWidget {
  const History({super.key});

  Future<List> getData() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/blubuklaundry/getdata.php'));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('History Transaksi'),
          leading: Builder(builder: (context) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomerInfo()));
              },
              child: const Icon(
                Icons.arrow_back,
              ),
            );
          }),
        ),
        body: FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            // ignore: avoid_print
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? ItemList(
                    list: snapshot.data!,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});

  // void deletedata() {
  //   var url = "http://localhost:8080/blubuklaundry/deleteData.php";
  //   var widget;
  //   http.post(Uri.parse(url),
  //       body: {'invoice': widget.list[widget.index]['invoice']});
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50,
              color: const Color.fromRGBO(190, 208, 238, 1),
              child: Center(child: Text(list[i]['invoice'])),
            ),
            Container(
              width: 140,
              color: const Color.fromRGBO(214, 206, 130, 1),
              child: Center(child: Text(list[i]['waktu'])),
            ),
            Container(
              width: 220,
              color: const Color.fromRGBO(190, 208, 238, 1),
              child: Center(child: Text(list[i]['tanggal'])),
            ),
            Container(
              width: 180,
              color: const Color.fromRGBO(214, 206, 130, 1),
              child: Center(child: Text(list[i]['metode_ambil'])),
            ),
            Container(
              width: 200,
              color: const Color.fromRGBO(190, 208, 238, 1),
              child: Center(child: Text(list[i]['jenis_layanan'])),
            ),
            Container(
              width: 200,
              color: const Color.fromRGBO(214, 206, 130, 1),
              child: Center(child: Text(list[i]['jenis_bahan'])),
            ),
            Container(
              width: 60,
              color: const Color.fromRGBO(190, 208, 238, 1),
              child: Center(child: Text(list[i]['berat'])),
            ),
            Container(
              width: 140,
              color: const Color.fromRGBO(214, 206, 130, 1),
              child: Center(child: Text(list[i]['harga_pokok'])),
            ),
            SizedBox(
              width: 10,
              child: Container(
                child: InkWell(
                  onTap: () {
                    // deletedata();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const History()));
                  },
                  child: const Icon(
                    Icons.refresh,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
              child: Container(
                child: InkWell(
                  onTap: () {
                    // deletedata();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Dashboard()));
                  },
                  child: const Icon(
                    Icons.home,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
