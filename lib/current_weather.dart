import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p_12_api_weather/change_image_icon.dart';
import 'package:p_12_api_weather/constant.dart';
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
          shadowColor: Colors.grey.shade700,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: size.height * 0.9,
            width: size.width,
            decoration: BoxDecoration(),
            child: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: Column(
                children: [
                  FutureBuilder(
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
                        return Container(
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.9),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              CircularProgressIndicator(color: Colors.yellow),
                              SizedBox(
                                height: 10,
                              ),
                              DefaultTextStyle(
                                style: kTextStyleAnimatedText,
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      'Please Enter Correct City...',
                                      speed: Duration(milliseconds: 150),
                                    ),
                                  ],
                                  repeatForever: true,
                                  stopPauseOnTap: true,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    future: getCurrentWeather(),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 9,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          shadowColor: Colors.tealAccent,
                          primary: Colors.indigo.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(
                              color: Colors.yellow.withOpacity(0.9), width: 1)),
                      onPressed: () {
                        setState(() {
                          showMaterialDialog();
                        });
                      },
                      child: DefaultTextStyle(
                        style: kTextStyleAnimatedText.copyWith(
                            color: Colors.white),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('Search'),
                          ],
                          repeatForever: true,
                          stopPauseOnTap: false,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
  }

  Widget weatherBox(Weather _weather) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height / 3.5,
          width: size.width,
          decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: backChange(_weather.temp), //double.parse(temp)
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text('City:   ${_weather.cityName}',
                              style: kTextStyleNormal.copyWith(
                                  color: textColor(_weather.temp))),
                          Text(
                            "date:  ${DateFormat('yyyy/MM/dd').format(_weather.dt)}",
                            style: kTextStyleNormal.copyWith(
                                color: textColor(_weather.temp)),
                          ),
                          Text(
                            "time:  ${DateFormat('hh:mm').format(_weather.dt)}",
                            style: kTextStyleNormal.copyWith(
                                color: textColor(_weather.temp)),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.location_on),
                    ],
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Image(
                      image: iconChange(_weather.description),
                    ),
                  ),
                ),
              ),
              Text(
                '${_weather.temp.toString().substring(0, 2)}ºC',
                style: kTextStyleTemp.copyWith(
                  color: textColor(_weather.temp),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: size.height / size.height * 150,
          width: size.width * 0.98,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'status:  ${_weather.description}',
                style: kTextStyleNormal,
              ),
              Text("Feels:${_weather.feelsLike.toString().substring(0, 2)}°C",
                  style: kTextStyleNormal),
              Text("Wind:${_weather.wind.toString()} KM/h",
                  style: kTextStyleNormal),
              Text("Country:  ${_weather.country}", style: kTextStyleNormal),
              Text(
                  "H:${_weather.high.toString().substring(0, 2)}°C    L:${_weather.low.toString().substring(0, 2)}°C",
                  style: kTextStyleNormal),
            ],
          ),
        ),
        Container(),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Future getCurrentWeather() async {
    try {
      Weather? weather;
      String apiKey = "f1d09f5ada183cbf37c18ebaac7f3748";
      var url =
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        weather = Weather.fromJson(jsonDecode(response.body));
      }
      return weather;
    } catch (e) {
      print(e);
    }
  }

  void showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter City:...'),
            content: CustomTextField(
              onPressed: () {
                setState(() {
                  city = cityController.text;
                  Navigator.pop(context);
                });
              },
              city: cityController,
            ),
            actions: <Widget>[
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: const[
                        Text('Exit'),
                        Icon(Icons.exit_to_app,color: Colors.red,),
                      ],
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        cityController.text = '';
                      });
                    },
                    child: Row(
                      children:const [
                        Text('Clear'),
                        Icon(Icons.arrow_back_sharp,color:Colors.white ,),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        });
  }
}
