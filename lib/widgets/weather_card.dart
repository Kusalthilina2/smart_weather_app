import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  final VoidCallback? onTap;

  const WeatherCard({super.key, required this.weather, this.onTap});

  @override
  Widget build(BuildContext context) {
    String lottieAsset = 'assets/sunny.json'; // Use Lottie files for different weather

    if (weather.description.contains('rain')) lottieAsset = 'assets/rain.json';
    if (weather.description.contains('cloud')) lottieAsset = 'assets/cloud.json';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              gradient: AppColors.gradient, borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              SizedBox(
                  width: 80, height: 80, child: Lottie.asset(lottieAsset, fit: BoxFit.cover)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(weather.cityName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text('${weather.temperature.toStringAsFixed(1)}°C',
                        style: const TextStyle(color: Colors.white)),
                    Text(weather.description, style: const TextStyle(color: Colors.white70)),
                    Text('Humidity: ${weather.humidity}%', style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
