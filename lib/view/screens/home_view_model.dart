import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sensors_app/model/chart_model.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

class HomeViewModel extends ChangeNotifier {
  List<String> dropButtonItem = ['X-AXIS', 'Y-AXIS', 'Z-AXIS'];
  String selectedItem = 'X-AXIS';
  String selectedGyroscopeItem = 'X-AXIS';
  String selectedMagnetometerItem = 'X-AXIS';
  bool xDataLineIsVisible = true;
  bool yDataLineIsVisible = false;
  bool zDataLineIsVisible = false;
  bool xDataLineGyroscopeIsVisible = true;
  bool yDataLineGyroscopeIsVisible = false;
  bool zDataLineGyroscopeIsVisible = false;
  bool xDataLineMagnetometerIsVisible = true;
  bool yDataLineMagnetometerIsVisible = false;
  bool zDataLineMagnetometerIsVisible = false;
  List<ChartDataModel> xDataList = [];
  List<ChartDataModel> yDataList = [];
  List<ChartDataModel> zDataList = [];
  List<ChartDataModel> xGyroscopeDataList = [];
  List<ChartDataModel> yGyroscopeDataList = [];
  List<ChartDataModel> zGyroscopeDataList = [];
  List<ChartDataModel> xMagnetometerDataList = [];
  List<ChartDataModel> yMagnetometerDataList = [];
  List<ChartDataModel> zMagnetometerDataList = [];

  List<String> header = ["x Axis", "y Axis", "Z Axis"];
  List<List<String>> chartData = [
    ["x Axis", "y Axis", "Z Axis"]
  ];
  List<List<String>> chartGyroscopeData = [
    ["x Axis", "y Axis", "Z Axis"]
  ];
  List<List<String>> chartMagnetometerData = [
    ["x Axis", "y Axis", "Z Axis"]
  ];

  int secondTime = 0;

  //chart Accelerometer controller
  late ChartSeriesController _chartSeriesXController;
  late ChartSeriesController _chartSeriesYController;
  late ChartSeriesController _chartSeriesZController;
  set chartSeriesXController(ChartSeriesController chartController) =>
      _chartSeriesXController = chartController;
  set chartSeriesYController(ChartSeriesController chartController) =>
      _chartSeriesYController = chartController;
  set chartSeriesZController(ChartSeriesController chartController) =>
      _chartSeriesZController = chartController;
  //Chart Gyroscope controller
  late ChartSeriesController _chartSeriesGyroscopeXController;
  late ChartSeriesController _chartSeriesGyroscopeYController;
  late ChartSeriesController _chartSeriesGyroscopeZController;
  set chartSeriesGyroscopeXController(ChartSeriesController chartController) =>
      _chartSeriesGyroscopeXController = chartController;
  set chartSeriesGyroscopeYController(ChartSeriesController chartController) =>
      _chartSeriesGyroscopeYController = chartController;
  set chartSeriesGyroscopeZController(ChartSeriesController chartController) =>
      _chartSeriesGyroscopeZController = chartController;
  //
  late ChartSeriesController _chartSeriesMagnetometerXController;
  late ChartSeriesController _chartSeriesMagnetometerYController;
  late ChartSeriesController _chartSeriesMagnetometerZController;
  set chartSeriesMagnetometerXController(
          ChartSeriesController chartController) =>
      _chartSeriesMagnetometerXController = chartController;
  set chartSeriesMagnetometerYController(
          ChartSeriesController chartController) =>
      _chartSeriesMagnetometerYController = chartController;
  set chartSeriesMagnetometerZController(
          ChartSeriesController chartController) =>
      _chartSeriesMagnetometerZController = chartController;

  late StreamSubscription _streamSubscription;
  late StreamSubscription _streamGyroscopeSubscription;
  late StreamSubscription _streamMagnetometerSubscription;

  //

  changeSelectedItem(String item) {
    selectedItem = item;
    xDataLineIsVisible = selectedItem == 'X-AXIS' ? true : false;
    yDataLineIsVisible = selectedItem == 'Y-AXIS' ? true : false;
    zDataLineIsVisible = selectedItem == 'Z-AXIS' ? true : false;
    debugPrint("xDataLineIsVisible=$xDataLineIsVisible");
    debugPrint("yDataLineIsVisible=$yDataLineIsVisible");
    debugPrint("zDataLineIsVisible=$zDataLineIsVisible");
    notifyListeners();
  }

  changeSelectedGyroscopeItem(String item) {
    selectedGyroscopeItem = item;

    print(selectedGyroscopeItem);
    xDataLineGyroscopeIsVisible =
        selectedGyroscopeItem == 'X-AXIS' ? true : false;
    yDataLineGyroscopeIsVisible =
        selectedGyroscopeItem == 'Y-AXIS' ? true : false;
    zDataLineGyroscopeIsVisible =
        selectedGyroscopeItem == 'Z-AXIS' ? true : false;
    debugPrint("xDataLineIsVisible=$xDataLineGyroscopeIsVisible");
    debugPrint("yDataLineIsVisible=$yDataLineGyroscopeIsVisible");
    debugPrint("zDataLineIsVisible=$zDataLineGyroscopeIsVisible");
    notifyListeners();
  }

  changeSelectedMagnetometerItem(String item) {
    selectedMagnetometerItem = item;
    xDataLineMagnetometerIsVisible =
        selectedMagnetometerItem == 'X-AXIS' ? true : false;
    yDataLineMagnetometerIsVisible =
        selectedMagnetometerItem == 'Y-AXIS' ? true : false;
    zDataLineMagnetometerIsVisible =
        selectedMagnetometerItem == 'Z-AXIS' ? true : false;
    debugPrint("xDataLineIsVisible=$xDataLineGyroscopeIsVisible");
    debugPrint("yDataLineIsVisible=$yDataLineGyroscopeIsVisible");
    debugPrint("zDataLineIsVisible=$zDataLineGyroscopeIsVisible");
    notifyListeners();
  }

  bool checkPaused() {
    return _streamSubscription.isPaused &&
            _streamGyroscopeSubscription.isPaused &&
            _streamMagnetometerSubscription.isPaused
        ? true
        : false;
  }

  void increaseTime() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _streamSubscription.isPaused &&
              _streamGyroscopeSubscription.isPaused &&
              _streamMagnetometerSubscription.isPaused
          ? null
          : secondTime++;

      notifyListeners();
    });
  }

  chartListen() {
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      print("==========================");
      print(event);
      updateDataXSource(timer: secondTime, x: event.x);
      updateDataYSource(timer: secondTime, x: event.y);
      updateDataZSource(timer: secondTime, x: event.z);
      chartData
          .add([event.x.toString(), event.y.toString(), event.z.toString()]);
      print(event.x);
    });

    _streamGyroscopeSubscription =
        gyroscopeEvents.listen((GyroscopeEvent event) {
      updateDataGyroscopeXSource(timer: secondTime, x: event.x);
      updateDataGyroscopeYSource(timer: secondTime, x: event.y);
      updateDataGyroscopeZSource(timer: secondTime, x: event.z);
      chartGyroscopeData
          .add([event.x.toString(), event.y.toString(), event.z.toString()]);
    });

    _streamMagnetometerSubscription =
        magnetometerEvents.listen((MagnetometerEvent event) {
      updateDataMagnetometerXSource(timer: secondTime, x: event.x);
      updateDataMagnetometerYSource(timer: secondTime, x: event.y);
      updateDataMagnetometerZSource(timer: secondTime, x: event.z);
      chartGyroscopeData
          .add([event.x.toString(), event.y.toString(), event.z.toString()]);
      notifyListeners();
    });
  }

  //update Accelerometer
  void updateDataXSource({required int timer, required double x}) {
    xDataList.add(ChartDataModel(time: timer, x: x));
    timer >= 10 ? xDataList.removeAt(0) : null;
    _chartSeriesXController.updateDataSource(
        addedDataIndex: xDataList.length - 1, removedDataIndex: 0);
  }

  void updateDataYSource({required int timer, required double x}) {
    yDataList.add(ChartDataModel(time: timer, x: x));
    timer >= 10 ? yDataList.removeAt(0) : null;
    _chartSeriesYController.updateDataSource(
        addedDataIndex: yDataList.length - 1, removedDataIndex: 0);
  }

  void updateDataZSource({required int timer, required double x}) {
    zDataList.add(ChartDataModel(time: timer, x: x));
    timer >= 10 ? zDataList.removeAt(0) : null;
    _chartSeriesZController.updateDataSource(
        addedDataIndex: zDataList.length - 1, removedDataIndex: 0);
  }

  //update Gyroscope
  void updateDataGyroscopeXSource({required int timer, required double x}) {
    xGyroscopeDataList.add(ChartDataModel(time: timer, x: x));
    timer >= 10 ? xGyroscopeDataList.removeAt(0) : null;
    _chartSeriesGyroscopeXController.updateDataSource(
        addedDataIndex: xGyroscopeDataList.length - 1, removedDataIndex: 0);
  }

  void updateDataGyroscopeYSource({required int timer, required double x}) {
    yGyroscopeDataList.add(ChartDataModel(time: timer, x: x));
    timer >= 10 ? yGyroscopeDataList.removeAt(0) : null;
    _chartSeriesGyroscopeYController.updateDataSource(
        addedDataIndex: yGyroscopeDataList.length - 1, removedDataIndex: 0);
  }

  void updateDataGyroscopeZSource({required int timer, required double x}) {
    zGyroscopeDataList.add(ChartDataModel(time: timer, x: x));
    timer >= 10 ? zGyroscopeDataList.removeAt(0) : null;
    _chartSeriesGyroscopeZController.updateDataSource(
        addedDataIndex: zGyroscopeDataList.length - 1, removedDataIndex: 0);
  }

  //update magnetometer
  void updateDataMagnetometerXSource({required int timer, required double x}) {
    xMagnetometerDataList.add(ChartDataModel(time: timer, x: x));
    timer >= 10 ? xMagnetometerDataList.removeAt(0) : null;
    _chartSeriesMagnetometerXController.updateDataSource(
        addedDataIndex: xMagnetometerDataList.length - 1, removedDataIndex: 0);
  }

  void updateDataMagnetometerYSource({required int timer, required double x}) {
    yMagnetometerDataList.add(ChartDataModel(time: timer, x: x));
    timer >= 10 ? yMagnetometerDataList.removeAt(0) : null;
    _chartSeriesMagnetometerYController.updateDataSource(
        addedDataIndex: yMagnetometerDataList.length - 1, removedDataIndex: 0);
  }

  void updateDataMagnetometerZSource({required int timer, required double x}) {
    zMagnetometerDataList.add(ChartDataModel(time: timer, x: x));
    timer >= 10 ? zMagnetometerDataList.removeAt(0) : null;
    _chartSeriesMagnetometerZController.updateDataSource(
        addedDataIndex: zMagnetometerDataList.length - 1, removedDataIndex: 0);
  }

  void stopChartListen() {
    // _streamSubscription.pause();
    if (_streamSubscription.isPaused &&
        _streamGyroscopeSubscription.isPaused &&
        _streamMagnetometerSubscription.isPaused) {
      _streamSubscription.resume();
      _streamGyroscopeSubscription.resume();
      _streamMagnetometerSubscription.resume();
    } else {
      _streamSubscription.pause();
      _streamGyroscopeSubscription.pause();
      _streamMagnetometerSubscription.pause();
    }
  }

  void exportData() {
    if (_streamSubscription.isPaused &&
        _streamGyroscopeSubscription.isPaused &&
        _streamMagnetometerSubscription.isPaused) {
      exportCSV.myCSV(header, chartData);
      exportCSV.myCSV(header, chartGyroscopeData);
    } else {
      print("play");
    }
  }
}
