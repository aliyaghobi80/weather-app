import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:p_12_api_weather/models/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:p_12_api_weather/widgets/custom_text_field.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  late Weather _weather;
  String city='tehran';
  TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Temperature'),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
        ));
  }
  Widget weatherBox(Weather _weather){
    return Column(
      children: [
        Text('${_weather.temp}ºC'),
        Text('${_weather.description}'),
        Text('Feels:${_weather.feelsLike}ºC'),
        Text('H:${_weather.high}ºC L:${_weather.low}ºC'),
      ],
    );
  }
  Future getCurrentWeather()async{
    Weather weather;
    String city="shiraz";
    String apiKey="YOUR API KEY";
    var url ="http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      weather= Weather.fromJson(jsonDecode(response.body));
    }
    else{
      // TODO:Throw error here
    }
  }
}
//after appid= into varible utl-> bad4ad67fe76157b5bc1ef846793019d