// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:app_laundry_bismillah/file%20yang%20masih%20dikembangkan/editdata.dart';
// import 'package:app_laundry_bismillah/main.dart';

// class Detail extends StatefulWidget {
//   List list;
//   int index;
//   Detail({required this.index, required this.list});
//   @override
//   _DetailState createState() => new _DetailState();
// }

// class _DetailState extends State<Detail> {
//   void deleteData() {
//     var url = "http://localhost/blubuklaundry/deleteData.php";
//     http.post(Uri.parse(url), body: {'id': widget.list[widget.index]['id']});
//   }

//   Future<void> confirm() async {
//     AlertDialog alertDialog = new AlertDialog(
//       content: new Text(
//           "Are You sure want to delete '${widget.list[widget.index]['item_name']}'"),
//       actions: <Widget>[
//         new ElevatedButton(
//           child: new Text(
//             "OK DELETE!",
//             style: new TextStyle(color: Colors.black),
//           ),
//           style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//           onPressed: () {
//             deleteData();
//             Navigator.of(context).push(new MaterialPageRoute(
//               builder: (BuildContext context) => new MyApp(),
//             ));
//           },
//         ),
//         new ElevatedButton(
//           child: new Text("CANCEL", style: new TextStyle(color: Colors.black)),
//           style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ],
//     );

//     await showDialog(context: context, builder: (context) => alertDialog);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//           title: new Text("${widget.list[widget.index]['item_name']}")),
//       body: new Container(
//         height: 370.0,
//         padding: const EdgeInsets.all(20.0),
//         child: new Card(
//           child: new Center(
//             child: new Column(
//               children: <Widget>[
//                 new Padding(
//                   padding: const EdgeInsets.only(top: 30.0),
//                 ),
//                 new Text(
//                   "Invoice : ${widget.list[widget.index]['invoice']}",
//                   style: new TextStyle(
//                       fontSize: 30.0, fontWeight: FontWeight.w700),
//                 ),
//                 new Text(
//                   "Waktu : ${widget.list[widget.index]['waktu']}",
//                   style: new TextStyle(fontSize: 18.0),
//                 ),
//                 new Text(
//                   "Tanggal : ${widget.list[widget.index]['tanggal']}",
//                   style: new TextStyle(fontSize: 18.0),
//                 ),
//                 new Text(
//                   "Metode Pengambilan : ${widget.list[widget.index]['metode_ambil']}",
//                   style: new TextStyle(fontSize: 18.0),
//                 ),
//                 new Text(
//                   "Jenis Layanan : ${widget.list[widget.index]['jenis_layanan']}",
//                   style: new TextStyle(fontSize: 18.0),
//                 ),
//                 new Text(
//                   "Jenis Bahan : ${widget.list[widget.index]['jenis_bahan']}",
//                   style: new TextStyle(fontSize: 18.0),
//                 ),
//                 new Text(
//                   "Berat : ${widget.list[widget.index]['berat']}",
//                   style: new TextStyle(fontSize: 18.0),
//                 ),
//                 new Text(
//                   "Harga Pokok : ${widget.list[widget.index]['harga_pokok']}",
//                   style: new TextStyle(fontSize: 18.0),
//                 ),
//                 new Padding(
//                   padding: const EdgeInsets.only(top: 30.0),
//                 ),
//                 new Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     new ElevatedButton(
//                       child: new Text("EDIT"),
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green),
//                       onPressed: () =>
//                           Navigator.of(context).push(new MaterialPageRoute(
//                         builder: (BuildContext context) => new Editdata(
//                             // list: widget.list,
//                             // index: widget.index,
//                             ),
//                       )),
//                     ),
//                     new ElevatedButton(
//                       child: new Text("DELETE"),
//                       style:
//                           ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                       onPressed: () => confirm(),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
