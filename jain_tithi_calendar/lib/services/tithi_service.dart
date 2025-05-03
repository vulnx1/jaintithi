import 'package:intl/intl.dart';
import '../models/daily_tithi.dart';

class TithiService {
  // Mock data fetching or calculation for a month
  static Future<Map<DateTime, DailyTithi>> fetchTithiForMonth(
    DateTime month, {
    required double latitude,
    required double longitude,
  }) async {
    final mockData = <DateTime, DailyTithi>{};
    for (int i = 1; i <= DateTime(month.year, month.month + 1, 0).day; i++) {
      final date = DateTime(month.year, month.month, i);
      final sunriseTime = _calculateSunriseTime(latitude, longitude);
      final sunsetTime = _calculateSunsetTime(latitude, longitude);

      mockData[date] = DailyTithi(
        date: date,
        tithiName: "Tithi ${i}", // Here, you can calculate the actual Tithi based on the date
        shubhDin: i % 5 == 0, // Just a mock condition for Shubh Din
        sunrise: sunriseTime,
        sunset: sunsetTime,
      );
    }
    return mockData;
  }

  // Helper method to mock sunrise time based on latitude
  static String _calculateSunriseTime(double latitude, double longitude) {
    return "${6 + (latitude % 2).toInt()}:00 AM"; // Mock sunrise logic
  }

  // Helper method to mock sunset time based on longitude
  static String _calculateSunsetTime(double latitude, double longitude) {
    return "${6 + (longitude % 2).toInt()}:30 PM"; // Mock sunset logic
  }
}
