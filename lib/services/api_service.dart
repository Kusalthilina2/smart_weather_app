import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../models/forecast_model.dart';

class ApiService {
  static const String apiKey = 'e38716cfa9f70248f82f67d36be00112';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  /// Get current weather by city or city,country
  Future<Weather?> getWeatherByCity(String query) async {
    try {
      final url = Uri.parse('$baseUrl/weather?q=$query&units=metric&appid=$apiKey');
      final res = await http.get(url);

      if (res.statusCode == 200) {
        return Weather.fromJson(json.decode(res.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Get 5-day forecast by city or city,country
  Future<List<DailyForecast>> getForecastByCity(String query) async {
    try {
      final url = Uri.parse('$baseUrl/forecast?q=$query&units=metric&appid=$apiKey');
      final res = await http.get(url);

      if (res.statusCode != 200) return [];

      final forecastList = json.decode(res.body)['list'] as List;

      Map<String, List<dynamic>> grouped = {};

      for (var f in forecastList) {
        String date = f['dt_txt'].substring(0, 10); // YYYY-MM-DD
        grouped.putIfAbsent(date, () => []).add(f);
      }

      List<DailyForecast> finalForecast = [];

      grouped.forEach((date, dayData) {
        double minTemp = 999;
        double maxTemp = -999;
        String mainDesc = dayData[0]['weather'][0]['description'];
        String icon = dayData[0]['weather'][0]['icon'];

        for (var item in dayData) {
          double temp = item['main']['temp'].toDouble();
          if (temp < minTemp) minTemp = temp;
          if (temp > maxTemp) maxTemp = temp;
        }

        finalForecast.add(DailyForecast(
          date: date,
          minTemp: minTemp,
          maxTemp: maxTemp,
          description: mainDesc,
          icon: icon,
        ));
      });

      return finalForecast.take(5).toList();
    } catch (e) {
      return [];
    }
  }
}
