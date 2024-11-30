import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_mate/pages/splash_screen.dart';
import 'pages/weather_base.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      home: WeatherBase(),

    );
  }
}
