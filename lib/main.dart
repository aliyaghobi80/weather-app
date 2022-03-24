import 'package:flutter/material.dart';
import 'package:p_12_api_weather/current_weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: CurrentWeatherPage(),
    );
  }
}