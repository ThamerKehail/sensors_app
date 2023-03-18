import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensors_app/sensor_chart.dart';
import 'package:sensors_app/view/screens/home_screen.dart';
import 'package:sensors_app/view/screens/home_view_model.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'chart.dart';
import 'const.dart';
import 'csv_test.dart';
import 'model/chart_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        //home: MyHomePage(title: "Thamer"),
        //home: Home(),
        home: HomeScreen(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double x = 0, y = 0, z = 0;
  String direction = "none";

  List yData = [];
  List zData = [];

  @override
  void initState() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      print("==========================");
      print(event);
      print(DateTime.now().second);
      print(event.x);
      xData
          .add(ChartDataModel(time: DateTime.now().second.toInt(), x: event.x));
      print('xData.length=====${xData.length}');
      print("==========================");

      x = event.x;
      y = event.y;
      z = event.z;

      //rough calculation, you can use
      //advance formula to calculate the orentation
      if (x > 0) {
        direction = "back";
      } else if (x < 0) {
        direction = "forward";
      } else if (y > 0) {
        direction = "left";
      } else if (y < 0) {
        direction = "right";
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gyroscope Sensor in Flutter"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          child: Column(children: [
            Text(
              direction,
              style: TextStyle(fontSize: 30),
            )
          ])),
    );
  }
}
