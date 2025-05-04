import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/daily_tithi.dart';
import '../models/ritual_timings.dart';

class TithiService {
  // Base URL for Sunrise and Sunset API
  static const String _sunApiBase = 'https://api.sunrise-sunset.org/json';

  /// Fetch sunrise, sunset, and calculate ritual timings for a given location and date
  static Future<DailyTithi?> fetchTithiAndTimings(
    double latitude,
    double longitude,
    DateTime date,
  ) async {
    try {
      // Format the date as yyyy-MM-dd
      final dateStr = DateFormat('yyyy-MM-dd').format(date);

      // Construct the URL for API call with latitude, longitude, and formatted date
      final url =
          '$_sunApiBase?lat=$latitude&lng=$longitude&date=$dateStr&formatted=0';

      // Make the API call and wait for the response
      final response = await http.get(Uri.parse(url));

      // Check if the response status is OK (200)
      if (response.statusCode == 200) {
        // Parse the response JSON
        final data = jsonDecode(response.body)['results'];

        // Convert the sunrise and sunset times to local DateTime objects
        final sunrise = DateTime.parse(data['sunrise']).toLocal();
        final sunset = DateTime.parse(data['sunset']).toLocal();

        // Mocked Tithi for now, this can be replaced with real logic or API
        final tithiName = _mockTithiName(date);

        // Calculate ritual timings
        final ritualTimings = _calculateRitualTimings(sunrise, sunset);

        // Return the DailyTithi object
        return DailyTithi(
          date: date,
          tithiName: tithiName,
          sunrise: sunrise,
          sunset: sunset,
          ritualTimings: ritualTimings,
        );
      } else {
        print('API Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching Tithi: $e');
      return null;
    }
  }

  /// Mock Tithi names based on date (this can be replaced with real logic)
  static String _mockTithiName(DateTime date) {
    const tithis = [
      'Pratipada', 'Dwitiya', 'Tritiya', 'Chaturthi', 'Panchami',
      'Shashti', 'Saptami', 'Ashtami', 'Navami', 'Dashami',
      'Ekadashi', 'Dwadashi', 'Trayodashi', 'Chaturdashi', 'Purnima'
    ];

    // Cycle through the list of Tithis using the day of the month
    return tithis[date.day % tithis.length];
  }

  /// Calculate ritual timings based on sunrise and sunset times
  static RitualTimings _calculateRitualTimings(DateTime sunrise, DateTime sunset) {
    final totalDuration = sunset.difference(sunrise);  // Duration between sunset and sunrise
    final prahar = totalDuration ~/ 4;  // Calculate one prahar (quarter of the duration)

    // Return the calculated ritual timings
    return RitualTimings(
      navkarshi: sunrise.add(const Duration(minutes: 48)),  // Navkarshi = 48 mins after sunrise
      porsi: sunrise.add(prahar),  // Porsi = 1 prahar after sunrise
      sadhPorsi: sunrise.add(Duration(minutes: (prahar.inMinutes * 1.5).round())),  // Sadh Porsi = 1.5 prahars after sunrise
      purimaddha: sunrise.add(prahar * 2),  // Purimaddha = 2 prahars after sunrise
      avaddha: sunrise.add(prahar * 3),  // Avaddha = 3 prahars after sunrise
    );
  }
}
