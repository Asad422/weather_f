import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_f/entity/weather_model.dart';

class WeatherDataProvider {
  static const apiKey = '2c57655acbf0401b96b170946240407';
  static const request = 'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&days=14&q=Saint-Petersburg';
  final dio = Dio();
  Future<List<WeatherModel>> getData() async {
    final response = await dio.get(request);
    final body = json.decode(response.toString());
    final List bodyList = body['forecast']['forecastday'];
    if (response.statusCode == 200) {
      final List<WeatherModel> toReturn = bodyList
          .map((forecast) => WeatherModel(
              weather: forecast['day']['condition']['text'],
              icon: forecast['day']['condition']['icon'],
              date: forecast['date']))
          .toList();
      return toReturn;
    }
    return [];
  }
  Future<List<WeatherModel>> getDataForSelectedDay(String date) async {
    final response = await dio.get(request);
    if (response.statusCode == 200) {
      final body = json.decode(response.toString());
      final List bodyList = body['forecast']['forecastday']
          .where((e) => e['date'] == date)
          .first['hour'];
      final List<WeatherModel> toReturn = bodyList
          .map((e) => WeatherModel(
              weather: e['condition']['text'],
              icon: e['condition']['icon'],
              date: e['time']))
          .toList();
      return toReturn;
    }
    return [];
  }
}
