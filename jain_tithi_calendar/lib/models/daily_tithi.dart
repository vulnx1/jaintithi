import 'package:jain_tithi_calendar/models/ritual_timings.dart';

class DailyTithi {
  final DateTime date;
  final String tithiName;
  final DateTime sunrise;
  final DateTime sunset;
  final RitualTimings ritualTimings;  // Added ritualTimings field

  DailyTithi({
    required this.date,
    required this.tithiName,
    required this.sunrise,
    required this.sunset,
    required this.ritualTimings,  // Ensure the ritualTimings parameter is passed
  });

  // Optional: factory method if parsing from API/JSON
  factory DailyTithi.fromJson(Map<String, dynamic> json) {
    return DailyTithi(
      date: DateTime.parse(json['date']),
      tithiName: json['tithiName'],
      sunrise: DateTime.parse(json['sunrise']),
      sunset: DateTime.parse(json['sunset']),
      ritualTimings: RitualTimings.fromJson(json['ritualTimings']),  // Ensure correct deserialization
    );
  }

  get shubhDin => null;

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'tithiName': tithiName,
      'sunrise': sunrise.toIso8601String(),
      'sunset': sunset.toIso8601String(),
      'ritualTimings': ritualTimings.toJson(),  // Serialize ritualTimings
    };
  }
}
