class DailyTithi {
  final DateTime date;
  final String tithiName;
  final DateTime sunrise;
  final DateTime sunset;

  DailyTithi({
    required this.date,
    required this.tithiName,
    required this.sunrise,
    required this.sunset,
  });

  // Optional: factory method if parsing from API/JSON
  factory DailyTithi.fromJson(Map<String, dynamic> json) {
    return DailyTithi(
      date: DateTime.parse(json['date']),
      tithiName: json['tithiName'],
      sunrise: DateTime.parse(json['sunrise']),
      sunset: DateTime.parse(json['sunset']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'tithiName': tithiName,
      'sunrise': sunrise.toIso8601String(),
      'sunset': sunset.toIso8601String(),
    };
  }
}
