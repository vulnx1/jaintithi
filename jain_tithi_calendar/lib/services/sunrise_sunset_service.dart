import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class SunriseSunsetService {
  static Future<Map<String, dynamic>> getSunriseSunsetByCity(String city) async {
    try {
      // Get coordinates from city name
      List<Location> locations = await locationFromAddress(city);
      double lat = locations.first.latitude;
      double lon = locations.first.longitude;

      // Format date
      String date = DateTime.now().toIso8601String().split('T').first;

      // API call
      final url = Uri.parse(
        'https://api.sunrise-sunset.org/json?lat=$lat&lng=$lon&date=$date',
      );

      final response = await http.get(url);
      if (response.statusCode != 200) throw Exception('API Error');

      final result = jsonDecode(response.body)['results'];

      // Convert UTC to IST
      final istOffset = Duration(hours: 5, minutes: 30);
      final sunrise = DateTime.parse("1970-01-01T${result['sunrise']}Z").add(istOffset);
      final sunset = DateTime.parse("1970-01-01T${result['sunset']}Z").add(istOffset);

      return {
        'sunrise': sunrise,
        'sunset': sunset,
        'latitude': lat,
        'longitude': lon,
      };
    } catch (e) {
      throw Exception('Failed to get sunrise/sunset: $e');
    }
  }
}
