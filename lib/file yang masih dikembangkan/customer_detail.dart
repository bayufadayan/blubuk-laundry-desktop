// import 'dart:convert';

// import 'package:app_laundry_bismillah/add_data.dart';
// import 'package:app_laundry_bismillah/customer_info.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:app_laundry_bismillah/detail.dart';

// class History extends StatelessWidget {
//   const History({super.key});

//   Future<List> getData() async {
//     final response =
//         await http.get(Uri.parse('http://localhost/blubuklaundry/getdata.php'));
//     return json.decode(response.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("History"),
//           leading: Builder(builder: (context) {
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const CustomerInfo()));
//               },
//               child: Icon(
//                 Icons.menu,
//               ),
//             );
//           }),
//         ),
//         floatingActionButton: new FloatingActionButton(
//           child: new Icon(Icons.add),
//           onPressed: () {},
//           // onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
//           //   builder: (BuildContext context) => new AddData(),
//           // )),
//         ),
//         body: FutureBuilder<List>(
//           future: getData(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) print(snapshot.error);

//             return snapshot.hasData
//                 ? ItemList(
//                     list: snapshot.data!,
//                   )
//                 : new Center(
//                     child: new CircularProgressIndicator(),
//                   );
//           },
//         ),
//       ),
//     );
//   }
// }

// class ItemList extends StatelessWidget {
//   final List list;
//   ItemList({required this.list});

//   @override
//   Widget build(BuildContext context) {
//     return new ListView.builder(
//       itemCount: list == null ? 0 : list.length,
//       itemBuilder: (context, i) {
//         return new Container(
//           padding: const EdgeInsets.all(10.0),
//           child: new InkWell(
//             onTap: () => Navigator.of(context).push(new MaterialPageRoute(
//                 builder: (BuildContext context) => Detail(
//                       list: list,
//                       index: i,
//                     ))),
//             child: new Card(
//               child: new ListTile(
//                 title: new Text(list[i]['jenis_bahan']),
//                 leading: new Icon(Icons.widgets),
//                 subtitle: new Text("Waktu : ${list[i]['waktu']}"),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//     // ListView.builder(
//     //   itemCount: list == null ? 0 : list.length,
//     //   itemBuilder: (context, i) {
//     //     return new Row(
//     //       mainAxisAlignment: MainAxisAlignment.center,
//     //       children: <Widget>[
//     //         Container(
//     //           width: 50,
//     //           color: Color.fromRGBO(190, 208, 238, 1),
//     //           child: Center(child: Text(list[i]['invoice'])),
//     //         ),
//     //         Container(
//     //           width: 140,
//     //           color: Color.fromRGBO(214, 206, 130, 1),
//     //           child: Center(child: Text(list[i]['waktu'])),
//     //         ),
//     //         Container(
//     //           width: 220,
//     //           color: Color.fromRGBO(190, 208, 238, 1),
//     //           child: Center(child: Text(list[i]['tanggal'])),
//     //         ),
//     //         Container(
//     //           width: 180,
//     //           color: Color.fromRGBO(214, 206, 130, 1),
//     //           child: Center(child: Text(list[i]['metode_ambil'])),
//     //         ),
//     //         Container(
//     //           width: 200,
//     //           color: Color.fromRGBO(190, 208, 238, 1),
//     //           child: Center(child: Text(list[i]['jenis_layanan'])),
//     //         ),
//     //         Container(
//     //           width: 200,
//     //           color: Color.fromRGBO(214, 206, 130, 1),
//     //           child: Center(child: Text(list[i]['jenis_bahan'])),
//     //         ),
//     //         Container(
//     //           width: 60,
//     //           color: Color.fromRGBO(190, 208, 238, 1),
//     //           child: Center(child: Text(list[i]['berat'])),
//     //         ),
//     //         Container(
//     //           width: 140,
//     //           color: Color.fromRGBO(214, 206, 130, 1),
//     //           child: Center(child: Text(list[i]['harga_pokok'])),
//     //         ),
//     //         Container(
//     //           width: 60,
//     //           color: Color.fromRGBO(190, 208, 238, 1),
//     //           child: Center(child: Text(list[i]['id_customers'])),
//     //         ),
//     //       ],
//     //     );
//     //   },
//     // );
//   }
// }
