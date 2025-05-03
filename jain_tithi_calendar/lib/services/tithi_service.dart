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
    final Map<DateTime, DailyTithi> data = {};
    final formattedMonth = "${month.year}-${_pad(month.month)}";

    try {
      final response = await http.get(Uri.parse(
        '$_apiUrl?latitude=$latitude&longitude=$longitude&month=$formattedMonth&language=en'
      ));

      if (response.statusCode != 200) {
        throw Exception('API Error: ${response.statusCode}');
      }

      final panchangData = json.decode(response.body);
      
      for (final dayData in panchangData['panchang']) {
        final date = DateTime.parse(dayData['date']);
        final sunrise = DateTime.parse(dayData['sunrise']).toLocal();
        final sunset = DateTime.parse(dayData['sunset']).toLocal();
        final tithi = dayData['tithi']['name'];
        
        data[date] = DailyTithi(
          date: date,
          sunrise: _formatTime(sunrise),
          sunset: _formatTime(sunset),
          tithiName: tithi,
          shubhDin: _isShubhDin(date, tithi),
        );
      }

      return data;
    } catch (e) {
      throw Exception('Failed to fetch Tithi data: $e');
    }
  }

  static bool _isShubhDin(DateTime date, String tithi) {
    // Actual Shubh Din logic based on Jain traditions
    final weekday = date.weekday;
    return tithi.contains('Pratipada') || 
           tithi.contains('Panchami') || 
           (weekday == DateTime.friday && tithi.contains('Chaturthi'));
  }

  static String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  static String _pad(int number) => number.toString().padLeft(2, '0');
}
