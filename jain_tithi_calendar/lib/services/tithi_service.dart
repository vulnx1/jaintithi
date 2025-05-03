import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/daily_tithi.dart';

class TithiService {
  static const String _apiUrl = 'https://api.sunrise-sunset.org/json';

  static Future<Map<DateTime, DailyTithi>> fetchTithiForMonth(
    DateTime month, {
    required double latitude,
    required double longitude,
  }) async {
    final Map<DateTime, DailyTithi> data = {};

    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    for (int i = 1; i <= daysInMonth; i++) {
      final date = DateTime(month.year, month.month, i);
      final apiResponse = await _fetchSunriseSunsetData(latitude, longitude, date);

      final sunriseUTC = DateTime.parse(apiResponse['results']['sunrise']);
      final sunsetUTC = DateTime.parse(apiResponse['results']['sunset']);

      final sunriseLocal = sunriseUTC.toLocal().toIso8601String();
      final sunsetLocal = sunsetUTC.toLocal().toIso8601String();

      data[date] = DailyTithi(
        date: date,
        sunrise: sunriseLocal,
        sunset: sunsetLocal,
        tithiName: "Tithi $i", // Replace with actual Tithi logic
        shubhDin: i % 5 == 0,
      );
    }

    return data;
  }

  static Future<Map<String, dynamic>> _fetchSunriseSunsetData(
    double latitude,
    double longitude,
    DateTime date,
  ) async {
    final formattedDate = "${date.year}-${_pad(date.month)}-${_pad(date.day)}";

    final url = Uri.parse(
      '$_apiUrl?lat=$latitude&lng=$longitude&date=$formattedDate&formatted=0',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch sunrise/sunset for $formattedDate');
    }
  }

  static String _pad(int number) => number.toString().padLeft(2, '0');
}
