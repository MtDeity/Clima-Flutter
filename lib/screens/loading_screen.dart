import 'dart:convert';

import 'package:clima/location.dart';
import 'package:clima/networking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = 'aa33a7c90cdc07fd0033a319b2a6a172';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey',
    );
    var weatherData = await networkHelper.getData();
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
            getLocationData();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
