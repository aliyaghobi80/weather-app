import 'package:flutter/material.dart';
import 'package:p_12_api_weather/models/weather.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('My Weather App'),
      ),
    );
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
}
