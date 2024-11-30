import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_mate/services/weather_service.dart';
import 'package:weather_mate/models/weather_model.dart';


class WeatherBase extends StatefulWidget {
  const WeatherBase({super.key});

  @override
  State<WeatherBase> createState() => _WeatherBaseState();
}

class _WeatherBaseState extends State<WeatherBase> {

  //api key
  final _weatherService = WeatherService('d765b9c6e5df7dbae4b061cc831ae173');
  Weather? _weather;

  //DarkMode Manual button
  bool _isDarkMode = false; //Tracks Dark mode state
  bool _isManualToggle = false; //Track if the user manually toggled Dark mode

  //fetch weather
  _fetchWeather() async {


    //get weather for city
    try{

      //get the current city
      String cityName = await _weatherService.getCurrentCity();

      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather =weather;
      });
    }
    catch (e){
      print(e);
    }
  }

  //weather animations

  String getWeatherAnimation(String? skyCondtion){
    if(skyCondtion == null) return 'assets/sunny.json'; //default

    final hour =DateTime.now().hour;
    bool isNight = hour>=19 || hour<7;

    switch(skyCondtion.toLowerCase()){
      case 'clouds': return 'assets/clouds.json';
      case 'few clouds':
        return isNight ? 'assets/nightclouds' : 'assets/few_clouds.json';
      case 'wind':
      case 'mist':
      case 'haze':
        return 'assets/haze_wind.json';
      case 'thunder':
      case 'thunderstorm': return 'assets/thunder.json';
      case 'rain':
      case 'drizzle':
        return isNight ? 'assets/nightrain.json' : 'assets/rain.json'; //for day and night animation
      case 'clear':
        return isNight ? 'assets/nightclear.json' : 'assets/sunny.json'; //for clear sky depending on time
      default:
        return isNight ? 'assets/nightclear.json' : 'assets/sunny.json'; //for clear sky depending on time
    }

  }

  //check if its night for dark mode
  bool isNight(){
    final hour = DateTime.now().hour;
    return 18>=hour || hour<7;
  }

  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();

    //Set the initial dark mode state based on the scheduled time
    _isDarkMode= isNight();

  }

  @override
  Widget build(BuildContext context) {
    bool night = _isManualToggle ? _isDarkMode: isNight();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: night ? Colors.grey[900] : Colors.grey[400],

        actions: [
          IconButton(
            icon: Icon(night ? Icons.wb_sunny: Icons.nightlight_round),
            color: night? Colors.grey[200]: Colors.grey[800],
            onPressed: (){
              setState(() {
                _isManualToggle = true;
                _isDarkMode = !night;
              });
            },
          )
        ],

      ),

       backgroundColor: night ? Colors.grey[900] : Colors.grey[400],

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),

            Icon(Icons.location_on_sharp,
            size: 24,
              color: night ? Colors.grey[400] : Colors.grey[700],
            ),

            SizedBox(height: 4),

            //city name
            Text(_weather?.cityName.toUpperCase() ?? "loading city..",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Oswald-VariableFont_wght',
              color: night ? Colors.grey[500]: Colors.grey[800],
              fontWeight: FontWeight.bold,
              letterSpacing: 1,

            ),
            ),

            SizedBox(height: 40),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.skycondition,)),

            //weather condition
              Text(_weather?.skycondition ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: night ? Colors.grey[400] : Colors.grey[700],
                fontFamily: 'Oswald-VariableFont_wght',
                letterSpacing: 2,
              ),
            ),

            //temperature
            Container(
              margin: EdgeInsets.fromLTRB(50, 150, 50, 30),
              child: Text('${_weather?.temperature.round()}°',
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: 'Oswald-VariableFont_wght',
                    color: night ? Colors.grey[500] : Colors.grey[900],
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  )
              ),
            ),

         ],
      ),
    ),

  );
 }
}
