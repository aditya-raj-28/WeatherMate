import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_mate/pages/weather_base.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {

    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 5),() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const WeatherBase()));
    });
  }

  String loading() {
    return 'assets/loading.json';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Lottie.asset(loading(),
    width: 200,
    height: 200,
    fit: BoxFit.contain,
        ),
      ),

    );
  }
}
