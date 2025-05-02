import '../models/daily_tithi.dart';

class TithiService {
  static Future<Map<DateTime, DailyTithi>> fetchTithiForMonth(
    DateTime month, {
    required double latitude,
    required double longitude,
  }) async {
    // Replace this with real API logic using lat/lon
    final mockData = <DateTime, DailyTithi>{};
    for (int i = 1; i <= DateTime(month.year, month.month + 1, 0).day; i++) {
      final date = DateTime(month.year, month.month, i);
      mockData[date] = DailyTithi(
        date: date,
        tithiName: "Tithi $i",
        shubhDin: i % 5 == 0,
        sunrise: "06:00 AM",
        sunset: "06:30 PM",
      );
    }
    return mockData;
  }
}