import 'dart:convert';

class Weather{
  late String cityName;
  late double temperature;
  late String skycondition;

  Weather ({
    required this.cityName,
    required this.temperature,
    required this.skycondition});


  factory Weather.fromjson(Map<String, dynamic> json){
    return Weather(cityName: json['name'], temperature: json['main']['temp'].toDouble(), skycondition: json['weather'][0]['main']);
  }
}
