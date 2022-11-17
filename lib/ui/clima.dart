import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica_1/model/weather.dart';

class WeatherService {
  Future<Weather> getWeatherData(String place) async {
    try {
      final queryParameters = {
        'key': 'e4d58731c76e461b97c175030221511',
        'q': place,
      };
      final uri =
          Uri.http('api.weatherapi.com', '/v1/current.json', queryParameters);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Can not get weather");
      }
    } catch (e) {
      rethrow;
    }
  }
}
