import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/daily_tithi.dart';
// ignore: unused_import
import '../utils/tithi_calculator.dart';

class TithiService {
  static const String _apiUrl = 'https://api.drikpanchang.com/v1/panchang';

  static Future<Map<DateTime, DailyTithi>> fetchTithiForMonth(
    DateTime month, {
    required double latitude,
    required double longitude,
  }) async {
    final Map<DateTime, DailyTithi> tithiMap = {};
    final formattedMonth = "${month.year}-${_pad(month.month)}";

    try {
      final uri = Uri.parse(
        '$_apiUrl?latitude=$latitude&longitude=$longitude&month=$formattedMonth&language=en',
      );
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('API Error: ${response.statusCode}');
      }

      final decoded = json.decode(response.body);
      final List<dynamic> days = decoded['panchang'];

      for (final day in days) {
        final date = DateTime.parse(day['date']);
        final sunrise = DateTime.parse(day['sunrise']).toLocal();
        final sunset = DateTime.parse(day['sunset']).toLocal();
        final tithi = day['tithi']['name'] ?? 'Unknown';

        tithiMap[date] = DailyTithi(
          date: date,
          sunrise: _formatTime(sunrise),
          sunset: _formatTime(sunset),
          tithiName: tithi,
          shubhDin: _isShubhDin(date, tithi),
        );
      }

      return tithiMap;
    } catch (e) {
      throw Exception('Failed to fetch Tithi data: $e');
    }
  }

  /// Determines if a day is considered a "Shubh Din" (auspicious day)
  static bool _isShubhDin(DateTime date, String tithi) {
    final weekday = date.weekday;
    return tithi.contains('Pratipada') ||
           tithi.contains('Panchami') ||
           (weekday == DateTime.friday && tithi.contains('Chaturthi'));
  }

  /// Formats time as HH:mm
  static String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  /// Pads a number with a leading zero if needed (e.g., 2 -> 02)
  static String _pad(int number) => number.toString().padLeft(2, '0');
}
