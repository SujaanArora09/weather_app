import 'location.dart';
import 'networking.dart';

const apiKey = '8446c6e47d27f41b1fa60e91e90c0b7e';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    var longitude = location.longitude;
    var latitude = location.latitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'https://assets8.lottiefiles.com/packages/lf20_qjq70sp1.json  ';
    } else if (condition < 400) {
      return 'https://assets4.lottiefiles.com/private_files/lf30_orqfuyox.json';
    } else if (condition < 600) {
      return 'https://assets7.lottiefiles.com/packages/lf20_DyDkQs.json';
    } else if (condition < 700) {
      return 'https://assets6.lottiefiles.com/packages/lf20_evSioT.json';
    } else if (condition < 800) {
      return 'https://assets4.lottiefiles.com/packages/lf20_vcxeqptb.json';
    } else if (condition == 800) {
      return 'https://assets1.lottiefiles.com/private_files/lf30_1xg5wkc5.json';
    } else if (condition <= 804) {
      return 'https://assets7.lottiefiles.com/temp/lf20_kOfPKE.json';
    } else {
      return 'https://assets4.lottiefiles.com/datafiles/QTlPpc31DnGUTW0/data.json';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'Looks like it\'s very hot';
    } else if (temp > 20) {
      return 'Spring Vibes!very good weather';
    } else if (temp < 10) {
      return 'It\'s cold outside , stay and enjoy bonfire';
    } else {
      return 'Loving the cold ? go outside have fun';
    }
  }
}
