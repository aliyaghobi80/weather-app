import 'package:flutter/material.dart';
import 'package:p_12_api_weather/constant.dart';
import 'package:p_12_api_weather/models/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:p_12_api_weather/widgets/custom_text_field.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  late Weather _weather;
  String city = 'tehran';
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('وضع هوا'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(),
            child: Container(
              decoration: BoxDecoration(color: Colors.blue),
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Center(
                    child: FutureBuilder(
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          _weather = snapshot.data;
                          if (_weather == null) {
                            return Text("Error getting weather");
                          } else {
                            return weatherBox(_weather);
                          }
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                      future: getCurrentWeather(),
                    ),
                  ),
                  CustomTextField(
                    city: cityController,
                    onPressed: () {
                      setState(() {
                        city = cityController.text;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget weatherBox(Weather _weather) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Container(
          margin: const EdgeInsets.all(10.0),
          child: Text(
            "${_weather.temp.toString().substring(0, 2)}°C",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
          )),
      Container(
          margin: const EdgeInsets.all(5.0),
          child: Text('status:  ${_weather.description}')),
      Container(
          margin: const EdgeInsets.all(5.0),
          child:
              Text("Feels:${_weather.feelsLike.toString().substring(0, 2)}°C")),
      Container(
          margin: const EdgeInsets.all(5.0),
          child: Text("Wind:${_weather.wind.toString()}")),
      Container(
          margin: const EdgeInsets.all(5.0),
          child: Text("Country:  ${_weather.country}")),
      Container(
          margin: const EdgeInsets.all(5.0),
          child: Text("cityName:  ${_weather.cityName}")),
      Container(
          margin: const EdgeInsets.all(5.0),
          child: Text("date:  ${DateFormat('yyyy/mm/d').format(_weather.dt)}")),
      Container(
          margin: const EdgeInsets.all(5.0),
          child: Text("time:  ${DateFormat('hh:mm:ss').format(_weather.dt)}")),
      Container(
          margin: const EdgeInsets.all(5.0),
          child: Text(
              "H:${_weather.high.toString().substring(0, 2)}°C    L:${_weather.low.toString().substring(0, 2)}°C")),
    ]);
  }

  Future getCurrentWeather() async {
    try {
      Weather? weather;
      String apiKey = "f1d09f5ada183cbf37c18ebaac7f3748";
      var url =
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&lang=fa&units=metric";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        weather = Weather.fromJson(jsonDecode(response.body));
      }
      return weather;
    } catch (e) {
      print(e);
    }
  }
}
