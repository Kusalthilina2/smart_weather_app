class DailyForecast {
  final String date;
  final double minTemp;
  final double maxTemp;
  final String description;
  final String icon;

  DailyForecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.icon,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: json['date'],
      minTemp: json['minTemp'],
      maxTemp: json['maxTemp'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}
