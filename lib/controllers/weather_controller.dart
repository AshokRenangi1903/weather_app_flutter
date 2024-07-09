import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherController {
  Future<WeatherModel> getWeatherDetails(double lat, double long) async {
    var weatherAPI =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=8fea27eb292c0f4c519a1514ed24f48f";
    var response = await http.get(Uri.parse(weatherAPI));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return WeatherModel.fromJson(body);
    } else {
      throw Exception("API error!!!");
    }
  }
}
