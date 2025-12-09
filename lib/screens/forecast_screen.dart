import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/forecast_card.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final list = provider.dailyForecast;

    return Scaffold(
      appBar: const CustomAppBar(title: "5-Day Forecast"),
      body: list.isEmpty
          ? const Center(child: Text("No forecast available"))
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ForecastCard(forecast: list[index]);
              },
            ),
    );
  }
}
