// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:to_csv/to_csv.dart' as exportCSV;
//
// import 'const.dart';
// import 'model/chart_model.dart';
//
// class SensorChart extends StatefulWidget {
//   const SensorChart({Key? key}) : super(key: key);
//
//   @override
//   State<SensorChart> createState() => _SensorChartState();
// }
//
// class _SensorChartState extends State<SensorChart> {
//   int x = 0;
//   DateTime now = DateTime.now();
//
//   @override
//   void initState() {
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       x++;
//       print("========== $x ========");
//     });
//     _streamSubscription =
//         accelerometerEvents.listen((AccelerometerEvent event) {
//       print("==========================");
//       print(event);
//       updateDataXSource(timer: x, x: event.x);
//       updateDataYSource(timer: x, x: event.y);
//       updateDataZSource(timer: x, x: event.z);
//       chartData
//           .add([event.x.toString(), event.y.toString(), event.z.toString()]);
//       print(event.x);
//
//       // xData.add(XData(time: DateTime.now().second.toInt(), x: event.x));
//       // print('xData.length=====${xData.length}');
//       // print("==========================");
//       // _chartSeriesController.updateDataSource(
//       //     addedDataIndex: xData.length - 1, removedDataIndex: 0);
//       // xData.removeAt(0);
//       //
//       setState(() {});
//     });
//     super.initState();
//   }
//
//   late ChartSeriesController _chartSeriesController;
//   late ChartSeriesController _chartSeriesYController;
//   late ChartSeriesController _chartSeriesZController;
//   void updateDataXSource({required int timer, required double x}) {
//     xData.add(ChartDataModel(time: timer, x: x));
//     timer >= 10 ? xData.removeAt(0) : null;
//     _chartSeriesController.updateDataSource(
//         addedDataIndex: xData.length - 1, removedDataIndex: 0);
//   }
//
//   void updateDataYSource({required int timer, required double x}) {
//     yData.add(ChartDataModel(time: timer, x: x));
//     timer >= 10 ? yData.removeAt(0) : null;
//     _chartSeriesYController.updateDataSource(
//         addedDataIndex: yData.length - 1, removedDataIndex: 0);
//   }
//
//   void updateDataZSource({required int timer, required double x}) {
//     zData.add(ChartDataModel(time: timer, x: x));
//     timer >= 10 ? zData.removeAt(0) : null;
//     _chartSeriesZController.updateDataSource(
//         addedDataIndex: zData.length - 1, removedDataIndex: 0);
//   }
//
//   late StreamSubscription _streamSubscription;
//   List<String> dropButtonItem = ['X-AXIS', 'Y-AXIS', 'Z-AXIS'];
//   String? selectedItem = 'X-AXIS';
//
//   bool xDataLine = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             floatingActionButton: FloatingActionButton(
//               onPressed: () {
//                 _streamSubscription.cancel();
//                 // exportCSV.myCSV(header, chartData);
//               },
//             ),
//             body: Column(
//               children: [
//                 Center(
//                   child: SizedBox(
//                     width: 200,
//                     child: DropdownButtonFormField<String>(
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                               const BorderSide(width: 3, color: Colors.blue),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                               const BorderSide(width: 3, color: Colors.blue),
//                         ),
//                       ),
//                       value: selectedItem,
//                       items: dropButtonItem
//                           .map((item) => DropdownMenuItem<String>(
//                               value: item,
//                               child: Text(
//                                 item,
//                                 style: const TextStyle(
//                                   fontSize: 24,
//                                 ),
//                               )))
//                           .toList(),
//                       onChanged: (item) => setState(() => selectedItem = item),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: SfCartesianChart(
//                       series: <LineSeries<ChartDataModel, int>>[
//                         LineSeries<ChartDataModel, int>(
//                           isVisible: true,
//                           onRendererCreated:
//                               (ChartSeriesController controller) {
//                             _chartSeriesController = controller;
//                           },
//                           dataSource: xData,
//                           color: const Color.fromRGBO(192, 108, 132, 1),
//                           xValueMapper: (ChartDataModel sales, _) => sales.time,
//                           yValueMapper: (ChartDataModel sales, _) => sales.x,
//                         ),
//                         LineSeries<ChartDataModel, int>(
//                           isVisible: false,
//                           onRendererCreated:
//                               (ChartSeriesController controller) {
//                             _chartSeriesYController = controller;
//                           },
//                           dataSource: yData,
//                           color: Colors.green,
//                           xValueMapper: (ChartDataModel sales, _) => sales.time,
//                           yValueMapper: (ChartDataModel sales, _) => sales.x,
//                         ),
//                         LineSeries<ChartDataModel, int>(
//                           isVisible: true,
//                           onRendererCreated:
//                               (ChartSeriesController controller) {
//                             _chartSeriesZController = controller;
//                           },
//                           dataSource: zData,
//                           color: Colors.blue,
//                           xValueMapper: (ChartDataModel sales, _) => sales.time,
//                           yValueMapper: (ChartDataModel sales, _) => sales.x,
//                         ),
//                       ],
//                       primaryXAxis: NumericAxis(
//                           majorGridLines: const MajorGridLines(width: 0),
//                           edgeLabelPlacement: EdgeLabelPlacement.shift,
//                           interval: 3,
//                           title: AxisTitle(text: 'Time (seconds)')),
//                       primaryYAxis: NumericAxis(
//                           axisLine: const AxisLine(width: 0),
//                           majorTickLines: const MajorTickLines(size: 0),
//                           title: AxisTitle(text: 'Internet speed (Mbps)'))),
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//               ],
//             )));
//   }
// }
