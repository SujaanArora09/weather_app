import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffB7E9F7), Color(0xffF5FCFF)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  WeatherModel weather = WeatherModel();
  late int temprature;
  late String weatherIcon;
  late String city;
  late String weatherMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temprature = 0;
        weatherIcon =
            'https://assets4.lottiefiles.com/datafiles/QTlPpc31DnGUTW0/data.json';
        weatherMessage = 'Try Again Later';
        city = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temprature = temp.toInt();
      weatherMessage = weather.getMessage(temp.toInt());
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      city = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: const BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment.topRight,
                  radius: 2,
                  colors: [Color(0xFF16c1F5), Color(0xFF126ef3)])),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: () async {
                              var weatherData =
                                  await weather.getLocationWeather();
                              updateUI(weatherData);
                            },
                            icon: const Icon(
                              Icons.my_location_rounded,
                              size: 29.0,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              var typedName = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CityScreen();
                              }));
                              if (typedName != null) {
                                var weatherData =
                                    await weather.getCityWeather(typedName);
                                updateUI(weatherData);
                              }
                            },
                            icon: const Icon(
                              Icons.manage_search_rounded,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF126ef3),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade700,
                                blurRadius: 15.0,
                                spreadRadius: 1.0,
                                offset: (Offset(4.0, 4.0)),
                              ),
                              const BoxShadow(
                                color: Colors.blue,
                                blurRadius: 15.0,
                                spreadRadius: 1.0,
                                offset: (Offset(-4.0, -4.0)),
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                height: 250,
                                child: Lottie.network(weatherIcon),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  '$temprature°',
                                  style: GoogleFonts.oswald(
                                      fontSize: 50,
                                      foreground: Paint()
                                        ..shader = linearGradient,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '$weatherMessage in $city !',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// double temprature = decodedData['main']['temp'];
// double condition = decodedData['weather'][0]['id'];
// double name = decodedData['name'];
