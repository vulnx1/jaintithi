import 'package:flutter/material.dart';
import '../models/daily_tithi.dart';
import '../utils/ritual_timings.dart';

class DayDetailPage extends StatelessWidget {
  final DateTime date;
  final DailyTithi tithi;

  const DayDetailPage({super.key, required this.date, required this.tithi});

  @override
  Widget build(BuildContext context) {
    // Convert HH:mm strings to DateTime (same day)
    final sunriseTime = _parseTime(tithi.sunrise, tithi.date);
    final sunsetTime = _parseTime(tithi.sunset, tithi.date);

    final rituals = calculateRitualTimings(sunriseTime, sunsetTime);

    return Scaffold(
      appBar: AppBar(
        title: Text("Details for ${_formatDate(tithi.date)}"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text("📅 Tithi: ${tithi.tithiName}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("☀️ Sunrise: ${tithi.sunrise}"),
            Text("🌇 Sunset: ${tithi.sunset}"),
            const Divider(height: 24),
            Text("🕉️ Ritual Timings", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...rituals.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text("${entry.key}: ${entry.value}", style: TextStyle(fontSize: 14)),
            )),
          ],
        ),
      ),
    );
  }

  DateTime _parseTime(String time, DateTime date) {
    final parts = time.split(':');
    return DateTime(date.year, date.month, date.day, int.parse(parts[0]), int.parse(parts[1]));
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
