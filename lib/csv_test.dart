// import 'dart:io';
//
// import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:to_csv/to_csv.dart' as exportCSV;
// import 'package:url_launcher/url_launcher.dart';
//
// class MyCsvPage extends StatefulWidget {
//   const MyCsvPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyCsvPage> createState() => _MyPageState();
// }
//
// class _MyPageState extends State<MyCsvPage> {
//   int _counter = 0;
//   List<String> header = []; //Header list variable
//   List<List<String>> listOfLists = [];
//   List<String> data1 = [
//     '1',
//     'Bilal Saeed',
//     '1374934',
//     '912839812'
//   ]; //Inner list which contains Data i.e Row
//   List<String> data2 = [
//     '2',
//     'Ahmar',
//     '21341234',
//     '192834821'
//   ]; //Inner list which contains Data i.e Row//Outter List which contains the data List
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     header.add('No.');
//     header.add('User Name');
//     header.add('Mobile');
//     header.add('ID Number');
//
//     listOfLists.add(header);
//     listOfLists.add(data1);
//     listOfLists.add(data2);
//     listOfLists.add(['sdfsdf', 'gggggggg', 'gdfgdfg']);
//   }
//
//   Widget HeaderRow() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 17, top: 12.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Text(
//             header[0],
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black87,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             header[1],
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black87,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             header[2],
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black87,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             header[3],
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black87,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//               HeaderRow(),
//               Divider(),
//               Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: ListView(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 12.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text(
//                             data1[0],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             data1[1],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             data1[2],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             data1[3],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 12.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text(
//                             data2[0],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             data2[1],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             data2[2],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             data2[3],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Container(
//             width: 130,
//             decoration: BoxDecoration(
//                 color: Colors.blue, borderRadius: BorderRadius.circular(12)),
//             child: TextButton(
//               child: const Text(
//                 'Export CV',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold),
//               ),
//               onPressed: () {
//                 exportCSV.myCSV(header, listOfLists);
//               },
//             ),
//           )), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
//
// class MyHomePageCsv extends StatefulWidget {
//   @override
//   _MyHomePageCsvState createState() => _MyHomePageCsvState();
// }
//
// class _MyHomePageCsvState extends State<MyHomePageCsv> {
//   List<List<dynamic>> csvData = [
//     ['Name', 'Age', 'Gender'],
//     ['John Doe', 30, 'Male'],
//     ['Jane Doe', 25, 'Female'],
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CSV Demo'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             // Request permission to write to device storage
//             var status = await Permission.storage.request();
//             if (status.isGranted) {
//               // Get the directory for storing the file
//               Directory appDocDir = await getApplicationDocumentsDirectory();
//               String appDocPath = appDocDir.path;
//
//               // Create the CSV file
//               File csvFile = File('$appDocPath/example.csv');
//               String csv = const ListToCsvConverter().convert(csvData);
//
//               // Write to the file
//               csvFile.writeAsString(csv);
//
//               // Download the file
//               if (await csvFile.exists()) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('CSV file downloaded'),
//                     duration: Duration(seconds: 3),
//                   ),
//                 );
//                 String filePath = csvFile.path;
//                 if (await canLaunch(filePath)) {
//                   await launch(filePath);
//                 } else {
//                   throw 'Could not launch $filePath';
//                 }
//               }
//             }
//           },
//           child: Text('Download CSV'),
//         ),
//       ),
//     );
//   }
// }
