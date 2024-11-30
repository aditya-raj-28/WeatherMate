import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_mate/models/weather_model.dart';

class WeatherService{
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  late String apiKey;

  WeatherService(this.apiKey);
  Future<Weather> getWeather (String cityName) async {

    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

     if (response.statusCode==200){
       return Weather.fromjson(jsonDecode(response.body));
     }else {
     throw Exception('Failed to load data');
     }
  }

  Future<String> getCurrentCity() async {

    //get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    //fetch the current location of the user
    Position position=await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );


    //convert the location into a list of placemark object
    List<Placemark> placemark =await placemarkFromCoordinates(position.latitude, position.longitude);


    //extract the city name from the first placemak

    String? city = placemark[0].locality;
    return city ?? "";

  }

}