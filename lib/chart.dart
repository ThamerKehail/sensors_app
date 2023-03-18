// import 'dart:async';
// import 'dart:math' as math;
//
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late List<LiveData> chartData;
//   late List<LiveData> chartData2;
//   late ChartSeriesController _chartSeriesController;
//   late ChartSeriesController _chartSeriesController2;
//
//   @override
//   void initState() {
//     chartData = getChartData();
//     chartData2 = getChartData2();
//     Timer.periodic(const Duration(seconds: 1), updateDataSource);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             body: SfCartesianChart(
//                 series: <LineSeries<LiveData, int>>[
//           LineSeries<LiveData, int>(
//             onRendererCreated: (ChartSeriesController controller) {
//               _chartSeriesController = controller;
//             },
//             dataSource: chartData,
//             color: const Color.fromRGBO(192, 108, 132, 1),
//             xValueMapper: (LiveData sales, _) => sales.time,
//             yValueMapper: (LiveData sales, _) => sales.speed,
//           ),
//           LineSeries<LiveData, int>(
//             onRendererCreated: (ChartSeriesController controller) {
//               _chartSeriesController2 = controller;
//             },
//             dataSource: chartData2,
//             color: Colors.green,
//             xValueMapper: (LiveData sales, _) => sales.time,
//             yValueMapper: (LiveData sales, _) => sales.speed,
//           ),
//         ],
//                 primaryXAxis: NumericAxis(
//                     majorGridLines: const MajorGridLines(width: 0),
//                     edgeLabelPlacement: EdgeLabelPlacement.shift,
//                     interval: 3,
//                     title: AxisTitle(text: 'Time (seconds)')),
//                 primaryYAxis: NumericAxis(
//                     axisLine: const AxisLine(width: 0),
//                     majorTickLines: const MajorTickLines(size: 0),
//                     title: AxisTitle(text: 'Internet speed (Mbps)')))));
//   }
//
//   int time = 19;
//   void updateDataSource(Timer timer) {
//     chartData.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
//     chartData.removeAt(0);
//     _chartSeriesController.updateDataSource(
//         addedDataIndex: chartData.length - 1, removedDataIndex: 0);
//     chartData2.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
//     chartData2.removeAt(0);
//     _chartSeriesController2.updateDataSource(
//         addedDataIndex: chartData2.length - 1, removedDataIndex: 0);
//   }
//
//   List<LiveData> getChartData() {
//     return <LiveData>[
//       LiveData(0, 42),
//       LiveData(1, 47),
//       LiveData(2, 43),
//       LiveData(3, 49),
//       LiveData(4, 54),
//       LiveData(5, 41),
//       LiveData(6, 58),
//       LiveData(7, 51),
//       LiveData(8, 98),
//       LiveData(9, 41),
//       LiveData(10, 53),
//       LiveData(11, 72),
//       LiveData(12, 86),
//       LiveData(13, 52),
//       LiveData(14, 94),
//       LiveData(15, 92),
//       LiveData(16, 86),
//       LiveData(17, 72),
//       LiveData(18, 94)
//     ];
//   }
//
//   List<LiveData> getChartData2() {
//     return <LiveData>[
//       LiveData(0, 42),
//       LiveData(9, 41),
//       LiveData(10, 53),
//       LiveData(14, 94),
//       LiveData(15, 92),
//       LiveData(16, 86),
//       LiveData(11, 72),
//       LiveData(12, 86),
//       LiveData(13, 52),
//       LiveData(1, 47),
//       LiveData(2, 43),
//       LiveData(3, 49),
//       LiveData(4, 54),
//       LiveData(5, 41),
//       LiveData(6, 58),
//       LiveData(7, 51),
//       LiveData(8, 98),
//       LiveData(17, 72),
//       LiveData(18, 94)
//     ];
//   }
// }
//
// class LiveData {
//   LiveData(this.time, this.speed);
//   final int time;
//   final num speed;
// }
