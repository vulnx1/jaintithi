import 'dart:convert';
import 'package:http/http.dart' as http;
import 'daily_tithi.dart';

class TithiService {
  static const String _apiUrl = 'https://api.sunrise-sunset.org/json';

  // Fetch the sunrise and sunset times from the API
  static Future<Map<DateTime, DailyTithi>> fetchTithiForMonth(
    DateTime month, {
    required double latitude,
    required double longitude,
  }) async {
    final mockData = <DateTime, DailyTithi>{};
    for (int i = 1; i <= DateTime(month.year, month.month + 1, 0).day; i++) {
      final date = DateTime(month.year, month.month, i);
      
      // Fetch sunrise and sunset data from the API
      final response = await _fetchSunriseSunsetData(latitude, longitude);
      final sunrise = response['results']['sunrise'];
      final sunset = response['results']['sunset'];

      mockData[date] = DailyTithi(
        date: date,
        tithiName: "Tithi ${i}", // You can implement actual Tithi calculation here
        shubhDin: i % 5 == 0, // Just mock data for Shubh Din
        sunrise: sunrise,
        sunset: sunset,
      );
    }
    return mockData;
  }

  // Fetch data from the Sunrise-Sunset API
  static Future<Map<String, dynamic>> _fetchSunriseSunsetData(double latitude, double longitude) async {
    final response = await http.get(Uri.parse('$_apiUrl?lat=$latitude&lng=$longitude&formatted=0'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load sunrise and sunset data');
    }
  }
}
