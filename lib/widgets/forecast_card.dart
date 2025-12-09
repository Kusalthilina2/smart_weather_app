import 'package:flutter/material.dart';
import '../models/forecast_model.dart';
import '../constants/colors.dart';

class ForecastCard extends StatelessWidget {
  final DailyForecast forecast;

  const ForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppColors.gradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Image.network(
              "https://openweathermap.org/img/wn/${forecast.icon}@2x.png",
              width: 60,
              height: 60,
            ),
            const SizedBox(width: 16),

            /// TEXT COLUMN
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  forecast.date,
                  style: const TextStyle(
                      fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  forecast.description,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 5),
                Text(
                  "${forecast.minTemp.toStringAsFixed(1)}°C / "
                  "${forecast.maxTemp.toStringAsFixed(1)}°C",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
