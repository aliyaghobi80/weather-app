class Weather {
  final double temp;
  final double feelsLike;
  final double low;
  final double high;
  final String description;
  final double wind;
  final String country;
  final String cityName;
 final DateTime dt;
  Weather({
    required this.wind,
    required this.temp,
    required this.feelsLike,
    required this.low,
    required this.high,
    required this.description,
    required this.country,
    required this.cityName,
    required this.dt,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      high: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'],
      wind: json['wind']['speed'].toDouble(),
      country: json['sys']['country'],
      cityName: json['name'],
      dt: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
    );
  }
}
