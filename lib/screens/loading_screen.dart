import 'package:WeatherApp/screens/location_screen.dart';
import 'package:WeatherApp/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool movetoNextScreen = true;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    var weatherInfo = await WeatherModel().getLocationData();

    if (weatherInfo == null) {
      showErrorDialog();
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherInfo,
      );
    }));
  }

  void showErrorDialog() {
    // show the alert if there is no weather data
    Alert(
      context: context,
      title: "Something Went Wrong",
      desc:
          "Check your internet settings or your location settings and try again!",
      image: Image.asset('images/error.png'),
      buttons: [
        DialogButton(
          child: Text(
            "Try Again",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.popAndPushNamed(context, '/'),
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPulse(
          color: Colors.white,
          size: 150.0,
        ),
      ),
    );
  }
}
