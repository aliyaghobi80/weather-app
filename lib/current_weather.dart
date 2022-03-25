import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_12_api_weather/models/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
          backgroundColor: Colors.grey.shade800,
          elevation: 1,
          shadowColor: Colors.red,
        ),
        body: Container(
          height: size.height / 2,
          width: size.width,
          decoration: BoxDecoration(),
          child: Container(
            decoration: BoxDecoration(color: Color(0xFFf1f1f1)),
            margin: EdgeInsets.all(2),
            child: Column(
              children: [
                FutureBuilder(
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      _weather = snapshot.data;
                      if (_weather == null) {
                        return Text("Error getting weather");
                      } else {
                        return weatherBox(_weather);
                      }
                    } else {
                      return Container(
                        width: size.width / 4,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        child: Column(
                          children: const [
                            CircularProgressIndicator(),
                            Text('Please Waite'),
                          ],
                        ),
                      );
                    }
                  },
                  future: getCurrentWeather(),
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
        ));
  }

  Widget weatherBox(Weather _weather) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Text('Location',style: kTextStyleNormal,),
        // Padding(padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
        // child:Text('${_weather.temp.toString()}ºC',style: kTextStyleNormal,),
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
          child: Text("date:  ${DateFormat('yyyy/MM/dd').format(_weather.dt)}")),
      Container(
          margin: const EdgeInsets.all(5.0),
          child: Text("time:  ${DateFormat('hh:mm').format(_weather.dt)}")),
      Container(
          margin: const EdgeInsets.all(5.0),
          child: Text(
              "H:${_weather.high.toString().substring(0, 2)}°C    L:${_weather.low.toString().substring(0, 2)}°C")),
      ],
    );
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
//data in wather box
//      Container(
//           margin: const EdgeInsets.all(10.0),
//           child: Text(
//             "${_weather.temp.toString().substring(0, 2)}°C",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
//           )),
//       Container(
//           margin: const EdgeInsets.all(5.0),
//           child: Text('status:  ${_weather.description}')),
//       Container(
//           margin: const EdgeInsets.all(5.0),
//           child:
//               Text("Feels:${_weather.feelsLike.toString().substring(0, 2)}°C")),
//       Container(
//           margin: const EdgeInsets.all(5.0),
//           child: Text("Wind:${_weather.wind.toString()}")),
//       Container(
//           margin: const EdgeInsets.all(5.0),
//           child: Text("Country:  ${_weather.country}")),
//       Container(
//           margin: const EdgeInsets.all(5.0),
//           child: Text("cityName:  ${_weather.cityName}")),
//       Container(
//           margin: const EdgeInsets.all(5.0),
//           child: Text("date:  ${DateFormat('yyyy/MM/dd').format(_weather.dt)}")),
//       Container(
//           margin: const EdgeInsets.all(5.0),
//           child: Text("time:  ${DateFormat('hh:mm').format(_weather.dt)}")),
//       Container(
//           margin: const EdgeInsets.all(5.0),
//           child: Text(
//               "H:${_weather.high.toString().substring(0, 2)}°C    L:${_weather.low.toString().substring(0, 2)}°C")),
