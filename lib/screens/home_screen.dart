import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/weather_provider.dart';
import 'city_weather_screen.dart';
import 'favorites_screen.dart';
import 'forecast_screen.dart';
import 'settings_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _searchCity() async {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    final query = _cityController.text.trim();

    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a city or country code (e.g., Colombo,LK)')),
      );
      return;
    }

    setState(() => _loading = true);

    bool success = await weatherProvider.fetchWeather(query);

    if (!mounted) return;

    setState(() => _loading = false);

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CityWeatherScreen(
            weather: weatherProvider.currentWeather!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('City or region not found!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withAlpha(255),
              AppColors.secondary.withAlpha(255),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // Welcome Card
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.white.withAlpha((0.15 * 255).round()),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.wb_sunny, size: 50, color: Colors.white),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Hello! Search your city to see the latest weather updates.',
                              style: TextStyle(
                                color: Colors.white.withAlpha((0.9 * 255).round()),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Search Box
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _cityController,
                              decoration: const InputDecoration(
                                hintText: 'Enter city or country (e.g., Colombo,LK)',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.search, color: AppColors.primary),
                            onPressed: _searchCity,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Loading Spinner
                  if (_loading)
                    const SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50,
                    ),

                  const SizedBox(height: 20),

                  // Quick Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _quickButton(
                          Icons.favorite,
                          'Favorites',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _quickButton(
                          Icons.cloud,
                          'Forecast',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ForecastScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Popular Sri Lankan Cities
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        'Colombo',
                        'Kandy',
                        'Galle',
                        'Jaffna',
                        'Negombo',
                        'Anuradhapura',
                        'Nuwara Eliya'
                      ].map((city) => _cityCard(city)).toList(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Bottom Message
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Stay updated and explore new cities!',
                        style: TextStyle(
                          color: Colors.white.withAlpha((0.85 * 255).round()),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _quickButton(IconData icon, String label, VoidCallback onTap) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.white.withAlpha((0.2 * 255).round()),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      icon: Icon(icon),
      label: Text(label),
      onPressed: onTap,
    );
  }

  Widget _cityCard(String cityName) {
    return GestureDetector(
      onTap: () {
        _cityController.text = cityName;
        _searchCity();
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha((0.2 * 255).round()),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            cityName,
            style: TextStyle(
              color: Colors.white.withAlpha((0.9 * 255).round()),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
