import 'package:WeatherApp/services/location.dart';
import 'package:WeatherApp/services/networking.dart';
import 'package:WeatherApp/utilities/constants.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String city) async {
    // Network Helper to do network requests
    NetworkHelper networkHelper = NetworkHelper(
        '$kOpenWeatherMapURL?q=$city&appid=$kApiKey&units=metric');
    var weatherInfo = await networkHelper.getData();
    return weatherInfo;
  }

  Future<dynamic> getLocationData() async {
    Location userLocation = Location();
    await userLocation.getCurrentLocation();

    // Network Helper to do network requests
    NetworkHelper networkHelper = NetworkHelper(
        '$kOpenWeatherMapURL?lat=${userLocation.latitude}&lon=${userLocation.longitude}&appid=$kApiKey&units=metric');
    var weatherInfo = await networkHelper.getData();
    return weatherInfo;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
