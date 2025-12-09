import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/weather_provider.dart';
import 'screens/splash_screen.dart';
import 'services/notification_service.dart';
import 'constants/colors.dart';
import 'providers/theme_provider.dart'; // Add ThemeProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init(); // Notification Init

  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Add ThemeProvider
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Smart Weather App',
            themeMode: themeProvider.currentTheme, // Use theme mode from provider
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primary,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 4,
              ),
              scaffoldBackgroundColor: Colors.white,
            ),
            darkTheme: ThemeData.dark().copyWith(
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
