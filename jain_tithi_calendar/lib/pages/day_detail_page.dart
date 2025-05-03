import 'package:flutter/material.dart';
import '../models/daily_tithi.dart';

class DayDetailPage extends StatelessWidget {
  final DateTime date;
  final DailyTithi? tithi;

  const DayDetailPage({
    super.key,
    required this.date,
    required this.tithi,
  });

  @override
  Widget build(BuildContext context) {
    if (tithi == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Day Details")),
        body: const Center(child: Text("No Tithi data available for this day.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(DateFormat('yyyy-MM-dd').format(date))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tithi: ${tithi!.tithiName}", style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 8),
            Text("Shubh Din: ${tithi!.shubhDin ? 'Yes' : 'No'}"),
            const SizedBox(height: 8),
            Text("Sunrise: ${tithi!.sunrise}"),
            const SizedBox(height: 8),
            Text("Sunset: ${tithi!.sunset}"),
            const SizedBox(height: 16),
            Divider(),
            const SizedBox(height: 16),
            Text("Rituals:"),
            _buildRitualRow("Prahar", _calculatePrahar(tithi!.sunrise, tithi!.sunset)),
            _buildRitualRow("Navkarshi", _calculateNavkarshi(tithi!.sunrise)),
            _buildRitualRow("Porsi", _calculatePorsi(tithi!.sunrise)),
            _buildRitualRow("Sadh Porsi", _calculateSadhPorsi(tithi!.sunrise)),
            _buildRitualRow("Purimaddha", _calculatePurimaddha(tithi!.sunrise)),
            _buildRitualRow("Avaddha", _calculateAvaddha(tithi!.sunrise)),
          ],
        ),
      ),
    );
  }

  Widget _buildRitualRow(String name, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text("$name: $time"),
    );
  }

  String _calculatePrahar(String sunrise, String sunset) {
    final sunriseHour = int.parse(sunrise.split(':')[0]);
    final sunsetHour = int.parse(sunset.split(':')[0]);
    final praharDuration = (sunsetHour - sunriseHour) / 8;
    final praharTime = sunriseHour + praharDuration;
    return "$praharTime:00 AM";
  }

  String _calculateNavkarshi(String sunrise) {
    final sunriseHour = int.parse(sunrise.split(':')[0]);
    final navkarshiTime = sunriseHour + 1;
    return "$navkarshiTime:48 AM";
  }

  String _calculatePorsi(String sunrise) {
    final sunriseHour = int.parse(sunrise.split(':')[0]);
    final porsiTime = sunriseHour + 3;
    return "$porsiTime:00 AM";
  }

  String _calculateSadhPorsi(String sunrise) {
    final sunriseHour = int.parse(sunrise.split(':')[0]);
    final sadhPorsiTime = sunriseHour + 3.5;
    return "$sadhPorsiTime:00 AM";
  }

  String _calculatePurimaddha(String sunrise) {
    final sunriseHour = int.parse(sunrise.split(':')[0]);
    final purimaddhaTime = sunriseHour + 6;
    return "$purimaddhaTime:00 AM";
  }

  String _calculateAvaddha(String sunrise) {
    final sunriseHour = int.parse(sunrise.split(':')[0]);
    final avaddhaTime = sunriseHour + 9;
    return "$avaddhaTime:00 AM";
  }
}
