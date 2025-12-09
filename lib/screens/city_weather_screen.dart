import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../models/weather_model.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_card.dart';
import '../services/notification_service.dart';

class CityWeatherScreen extends StatefulWidget {
  final Weather weather;

  const CityWeatherScreen({super.key, required this.weather});

  @override
  State<CityWeatherScreen> createState() => _CityWeatherScreenState();
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  bool _refreshing = false;

  void _notifyWeather(Weather weather) {
    NotificationService.showNotification(
        'Weather Alert for ${weather.cityName}',
        'Temperature: ${weather.temperature}°C, ${weather.description}');
  }

  Future<void> _refreshWeather() async {
    setState(() => _refreshing = true);

    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);

    await weatherProvider.fetchWeather(widget.weather.cityName);

    setState(() => _refreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final currentWeather = weatherProvider.currentWeather ?? widget.weather;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentWeather.cityName),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshWeather,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (_refreshing)
                const LinearProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.white24,
                ),
              WeatherCard(weather: currentWeather),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.favorite, color: Colors.white),
                    label: const Text('Add Favorite'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12)),
                    onPressed: () {
                      weatherProvider.addFavorite(currentWeather);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to favorites')));
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    label: const Text('Alert'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12)),
                    onPressed: () => _notifyWeather(currentWeather),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
