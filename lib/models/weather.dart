class Weather {
  final double temp;
  final double feelsLike;
  final double low;
  final double high;
  final double description;

  Weather(
      {required this.temp, required this.feelsLike, required this.low, required this.high, required this.description});

  factory Weather.fromJson(Map<String, dynamic>json){
    return Weather(temp: json['main']['temp'].toDouble(),
    feelsLike: json['main']['feels_like'].toDouble(),
    low:  json['main']['temp_min'].toDouble(),
    high:  json['main']['feels_max'].toDouble(),
    description:  json['main'][0]['feels_like'],);
  }
}