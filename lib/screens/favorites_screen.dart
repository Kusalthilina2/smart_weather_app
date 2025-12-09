import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_card.dart';
import 'city_weather_screen.dart';
import '../constants/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Cities'), backgroundColor: AppColors.primary),
      body: weatherProvider.favorites.isEmpty
          ? const Center(child: Text('No favorite cities yet'))
          : ListView.builder(
              itemCount: weatherProvider.favorites.length,
              itemBuilder: (context, index) {
                final weather = weatherProvider.favorites[index];
                return Stack(
                  children: [
                    WeatherCard(
                      weather: weather,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CityWeatherScreen(weather: weather)),
                        );
                      },
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          weatherProvider.removeFavorite(weather.cityName);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Removed from favorites')));
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
