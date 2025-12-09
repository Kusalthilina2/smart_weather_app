import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF2196F3); // Blue
  static const secondary = Color(0xFFFF9800); // Orange
  static const background = Color(0xFFF5F5F5); // Light Grey
  static const textPrimary = Colors.white;
  static const textSecondary = Colors.black87;

  // Gradient for splash screen and other areas
  static const LinearGradient gradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Helper getters if needed
  static const Color gradientStart = primary;
  static const Color gradientEnd = secondary;
}
