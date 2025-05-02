import 'package:flutter/material.dart';
import '../models/daily_tithi.dart';
import '../services/sunrise_sunset_service.dart';
import '../utils/custom_date_utils.dart';

class DayDetailPage extends StatelessWidget {
  final DateTime date;
  final DailyTithi? tithi;

  const DayDetailPage({super.key, required this.date, this.tithi});

  @override
  Widget build(BuildContext context) {
    final sunrise = SunriseSunsetService.calculateSunrise(date);
    final sunset = SunriseSunsetService.calculateSunset(date);
    final rituals = CustomDateUtils.calculateRitualTimings(sunrise, sunset);

    return Scaffold(
      appBar: AppBar(title: Text(CustomDateUtils.formatDate(date))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Tithi: ${tithi?.tithiName ?? 'Loading...'}"),
            const SizedBox(height: 10),
            Text("Shubh Din: ${tithi?.isShubhDin == true ? 'Yes' : 'No'}"),
            const SizedBox(height: 20),
            Text("Sunrise: ${CustomDateUtils.formatTime(sunrise)}"),
            Text("Sunset: ${CustomDateUtils.formatTime(sunset)}"),
            const SizedBox(height: 20),
            ...rituals.entries.map((entry) =>
              Text("${entry.key}: ${CustomDateUtils.formatTime(entry.value)}")),
          ],
        ),
      ),
    );
  }
}
