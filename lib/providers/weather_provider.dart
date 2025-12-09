import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';

class WeatherProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  Weather? _currentWeather;
  List<DailyForecast> _dailyForecast = [];
  final List<Weather> _favorites = [];

  Weather? get currentWeather => _currentWeather;
  List<DailyForecast> get dailyForecast => _dailyForecast;
  List<Weather> get favorites => _favorites;

  /// Fetch weather by city or city,country
  Future<bool> fetchWeather(String query) async {
    final weather = await _apiService.getWeatherByCity(query);

    if (weather != null) {
      _currentWeather = weather;
      _dailyForecast = await _apiService.getForecastByCity(query);
      notifyListeners();
      return true;
    }

    return false;
  }

  void addFavorite(Weather weather) {
    if (!_favorites.any((w) => w.cityName == weather.cityName)) {
      _favorites.add(weather);
      notifyListeners();
    }
  }

  void removeFavorite(String cityName) {
    _favorites.removeWhere((w) => w.cityName == cityName);
    notifyListeners();
  }
}
