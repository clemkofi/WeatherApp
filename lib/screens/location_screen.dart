
import 'package:rflutter_alert/rflutter_alert.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  String weatherIcon;
  int temperature;
  int conditionID;
  String cityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      conditionID = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(conditionID);

      cityName = weatherData['name'];
    });
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/back_1.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.deepPurple.withOpacity(0.8), BlendMode.hardLight),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationData();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var userCityName = await Navigator.pushNamed(context, '/city');
                      if(userCityName != null){
                        var weatherData = await weatherModel.getCityWeather(userCityName);
                        weatherData == null ? showErrorDialog() : updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '${weatherModel.getMessage(temperature)} in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// double temperature = jsonData['main']['temp'];
//       int conditionID = jsonData['weather'][0]['id'];
//       String cityName = jsonData['name'];
