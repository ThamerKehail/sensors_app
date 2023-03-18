import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensors_app/model/chart_model.dart';
import 'package:sensors_app/utils/const.dart';
import 'package:sensors_app/view/widget/home/custom_drop_down_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.microtask(() => context.read<HomeViewModel>().increaseTime());
    Future.microtask(() => context.read<HomeViewModel>().chartListen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeViewModel>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeProvider.stopChartListen();
          // exportCSV.myCSV(header, chartData);
        },
        child: homeProvider.checkPaused()
            ? const Icon(Icons.play_arrow)
            : const Icon(Icons.pause),
      ),
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              homeProvider.checkPaused()
                  ? homeProvider.exportData()
                  : showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Export File'),
                        content: const Text('The stream must be stopped'),
                        actions: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              color: Colors.blue,
                              child: Center(
                                  child: const Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                    );
            },
            icon: const Icon(Icons.cloud_download),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Accelerometer Chart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomDropDownButton(
                      value: homeProvider.selectedItem,
                      items: homeProvider.dropButtonItem
                          .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              )))
                          .toList(),
                      onChange: (String? item) =>
                          homeProvider.changeSelectedItem(item!)),
                  Column(
                    children: [
                      const Text(accelerometer),
                      Text(homeProvider.secondTime.toString()),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: SfCartesianChart(
                    series: <LineSeries<ChartDataModel, int>>[
                      LineSeries<ChartDataModel, int>(
                        isVisible: homeProvider.xDataLineIsVisible,
                        onRendererCreated: (ChartSeriesController controller) {
                          homeProvider.chartSeriesXController = controller;
                        },
                        dataSource: homeProvider.xDataList,
                        color: const Color.fromRGBO(192, 108, 132, 1),
                        xValueMapper: (ChartDataModel sales, _) => sales.time,
                        yValueMapper: (ChartDataModel sales, _) => sales.x,
                      ),
                      LineSeries<ChartDataModel, int>(
                        isVisible: homeProvider.yDataLineIsVisible,
                        onRendererCreated: (ChartSeriesController controller) {
                          homeProvider.chartSeriesYController = controller;
                        },
                        dataSource: homeProvider.yDataList,
                        color: Colors.green,
                        xValueMapper: (ChartDataModel sales, _) => sales.time,
                        yValueMapper: (ChartDataModel sales, _) => sales.x,
                      ),
                      LineSeries<ChartDataModel, int>(
                        isVisible: homeProvider.zDataLineIsVisible,
                        onRendererCreated: (ChartSeriesController controller) {
                          homeProvider.chartSeriesZController = controller;
                        },
                        dataSource: homeProvider.zDataList,
                        color: Colors.blue,
                        xValueMapper: (ChartDataModel sales, _) => sales.time,
                        yValueMapper: (ChartDataModel sales, _) => sales.x,
                      ),
                    ],
                    primaryXAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        interval: 3,
                        title: AxisTitle(text: 'Time (seconds)')),
                    primaryYAxis: NumericAxis(
                        axisLine: const AxisLine(width: 0),
                        majorTickLines: const MajorTickLines(size: 0),
                        title: AxisTitle(text: '(Ghz)'))),
              ),
              const SizedBox(
                height: 35,
              ),
              //Gyroscope Chart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomDropDownButton(
                      value: homeProvider.selectedGyroscopeItem,
                      items: homeProvider.dropButtonItem
                          .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              )))
                          .toList(),
                      onChange: (String? item) =>
                          homeProvider.changeSelectedGyroscopeItem(item!)),
                  const Text(gyroscope)
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: SfCartesianChart(
                    series: <LineSeries<ChartDataModel, int>>[
                      LineSeries<ChartDataModel, int>(
                        isVisible: homeProvider.xDataLineGyroscopeIsVisible,
                        onRendererCreated: (ChartSeriesController controller) {
                          homeProvider.chartSeriesGyroscopeXController =
                              controller;
                        },
                        dataSource: homeProvider.xGyroscopeDataList,
                        color: const Color.fromRGBO(192, 108, 132, 1),
                        xValueMapper: (ChartDataModel sales, _) => sales.time,
                        yValueMapper: (ChartDataModel sales, _) => sales.x,
                      ),
                      LineSeries<ChartDataModel, int>(
                        isVisible: homeProvider.yDataLineGyroscopeIsVisible,
                        onRendererCreated: (ChartSeriesController controller) {
                          homeProvider.chartSeriesGyroscopeYController =
                              controller;
                        },
                        dataSource: homeProvider.yGyroscopeDataList,
                        color: Colors.green,
                        xValueMapper: (ChartDataModel sales, _) => sales.time,
                        yValueMapper: (ChartDataModel sales, _) => sales.x,
                      ),
                      LineSeries<ChartDataModel, int>(
                        isVisible: homeProvider.zDataLineGyroscopeIsVisible,
                        onRendererCreated: (ChartSeriesController controller) {
                          homeProvider.chartSeriesGyroscopeZController =
                              controller;
                        },
                        dataSource: homeProvider.zGyroscopeDataList,
                        color: Colors.blue,
                        xValueMapper: (ChartDataModel sales, _) => sales.time,
                        yValueMapper: (ChartDataModel sales, _) => sales.x,
                      ),
                    ],
                    primaryXAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        interval: 3,
                        title: AxisTitle(text: 'Time (seconds)')),
                    primaryYAxis: NumericAxis(
                        axisLine: const AxisLine(width: 0),
                        majorTickLines: const MajorTickLines(size: 0),
                        title: AxisTitle(text: ' (GHz)'))),
              ),
              const SizedBox(
                height: 35,
              ),
              //Magnetometer Chart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomDropDownButton(
                      value: homeProvider.selectedMagnetometerItem,
                      items: homeProvider.dropButtonItem
                          .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              )))
                          .toList(),
                      onChange: (String? item) =>
                          homeProvider.changeSelectedMagnetometerItem(item!)),
                  const Text(magnetometer)
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: SfCartesianChart(
                    series: <LineSeries<ChartDataModel, int>>[
                      LineSeries<ChartDataModel, int>(
                        isVisible: homeProvider.xDataLineMagnetometerIsVisible,
                        onRendererCreated: (ChartSeriesController controller) {
                          homeProvider.chartSeriesMagnetometerXController =
                              controller;
                        },
                        dataSource: homeProvider.xMagnetometerDataList,
                        color: const Color.fromRGBO(192, 108, 132, 1),
                        xValueMapper: (ChartDataModel sales, _) => sales.time,
                        yValueMapper: (ChartDataModel sales, _) => sales.x,
                      ),
                      LineSeries<ChartDataModel, int>(
                        isVisible: homeProvider.yDataLineMagnetometerIsVisible,
                        onRendererCreated: (ChartSeriesController controller) {
                          homeProvider.chartSeriesMagnetometerYController =
                              controller;
                        },
                        dataSource: homeProvider.yMagnetometerDataList,
                        color: Colors.green,
                        xValueMapper: (ChartDataModel sales, _) => sales.time,
                        yValueMapper: (ChartDataModel sales, _) => sales.x,
                      ),
                      LineSeries<ChartDataModel, int>(
                        isVisible: homeProvider.zDataLineMagnetometerIsVisible,
                        onRendererCreated: (ChartSeriesController controller) {
                          homeProvider.chartSeriesMagnetometerZController =
                              controller;
                        },
                        dataSource: homeProvider.zMagnetometerDataList,
                        color: Colors.blue,
                        xValueMapper: (ChartDataModel sales, _) => sales.time,
                        yValueMapper: (ChartDataModel sales, _) => sales.x,
                      ),
                    ],
                    primaryXAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        interval: 3,
                        title: AxisTitle(text: 'Time (seconds)')),
                    primaryYAxis: NumericAxis(
                        axisLine: const AxisLine(width: 0),
                        majorTickLines: const MajorTickLines(size: 0),
                        title: AxisTitle(text: '(GHz)'))),
              ),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
