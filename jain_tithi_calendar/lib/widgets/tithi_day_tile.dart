import 'package:flutter/material.dart';
import '../models/daily_tithi.dart';

class TithiDayTile extends StatelessWidget {
  final DateTime date;
  final DailyTithi? tithi;

  const TithiDayTile({
    super.key,
    required this.date,
    required this.tithi,
  });

  void _showDetails(BuildContext context) {
    // Fetch sunrise and sunset times
    final sunriseTime = tithi?.sunrise ?? 'N/A';
    final sunsetTime = tithi?.sunset ?? 'N/A';

    // Convert to DateTime objects for calculation
    final sunrise = _parseTime(sunriseTime);
    final sunset = _parseTime(sunsetTime);

    // Calculate ritual timings based on sunrise and sunset
    final prahar1 = _calculatePrahar(sunrise, 1); // First Prahar
    final prahar2 = _calculatePrahar(sunrise, 2); // Second Prahar
    final prahar3 = _calculatePrahar(sunset, 3); // Third Prahar
    final prahar4 = _calculatePrahar(sunset, 4); // Fourth Prahar

    // Example for Navkarshi, Porsi, Sadh Porsi, Purimaddha, Avaddha
    final navkarshi = _calculateNavkarshi(sunrise);
    final porsi = _calculatePorsi(sunrise);
    final sadhPorsi = _calculateSadhPorsi(porsi as DateTime);
    final purimaddha = _calculatePurimaddha(sunset);
    final avaddha = _calculateAvaddha(sunset);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tithi Details - ${date.toLocal()}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Tithi: ${tithi?.tithiName ?? 'N/A'}'),
                Text('Sunrise: $sunriseTime'),
                Text('Sunset: $sunsetTime'),
                const SizedBox(height: 10),
                Text('Prahar 1: $prahar1'),
                Text('Prahar 2: $prahar2'),
                Text('Prahar 3: $prahar3'),
                Text('Prahar 4: $prahar4'),
                Text('Navkarshi: $navkarshi'),
                Text('Porsi: $porsi'),
                Text('Sadh Porsi: $sadhPorsi'),
                Text('Purimaddha: $purimaddha'),
                Text('Avaddha: $avaddha'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  DateTime _parseTime(String time) {
    final parts = time.split(':');
    return DateTime.utc(2000, 1, 1, int.parse(parts[0]), int.parse(parts[1]));
  }

  String _calculatePrahar(DateTime time, int praharNumber) {
    // Example: First Prahar = 6 AM to 9 AM
    int praharHour = time.hour + ((praharNumber - 1) * 3); // Adjust based on prahar number
    return "${praharHour.toString().padLeft(2, '0')}:00 - ${(praharHour + 3).toString().padLeft(2, '0')}:00";
  }

  String _calculateNavkarshi(DateTime sunrise) {
    // Fixed time, for example at sunrise + 1 hour
    final navkarshiTime = sunrise.add(const Duration(hours: 1));
    return "${navkarshiTime.hour.toString().padLeft(2, '0')}:${navkarshiTime.minute.toString().padLeft(2, '0')}";
  }

  String _calculatePorsi(DateTime sunrise) {
    // Fixed time after sunrise, let's assume 6 hours later
    final porsiTime = sunrise.add(const Duration(hours: 6));
    return "${porsiTime.hour.toString().padLeft(2, '0')}:${porsiTime.minute.toString().padLeft(2, '0')}";
  }

  String _calculateSadhPorsi(DateTime porsi) {
    // Fixed time after Porsi, let's assume 4 hours later
    final sadhPorsiTime = porsi.add(const Duration(hours: 4));
    return "${sadhPorsiTime.hour.toString().padLeft(2, '0')}:${sadhPorsiTime.minute.toString().padLeft(2, '0')}";
  }

  String _calculatePurimaddha(DateTime sunset) {
    // Fixed time after sunset, let's assume 1 hour later
    final purimaddhaTime = sunset.add(const Duration(hours: 1));
    return "${purimaddhaTime.hour.toString().padLeft(2, '0')}:${purimaddhaTime.minute.toString().padLeft(2, '0')}";
  }

  String _calculateAvaddha(DateTime sunset) {
    // Fixed time after sunset, let's assume 2 hours later
    final avaddhaTime = sunset.add(const Duration(hours: 2));
    return "${avaddhaTime.hour.toString().padLeft(2, '0')}:${avaddhaTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetails(context),
      child: Container(
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: tithi?.shubhDin ?? false ? Colors.green.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${date.day}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                tithi?.tithiName ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: tithi?.shubhDin ?? false ? Colors.green : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Sunrise: ${tithi?.sunrise ?? 'N/A'}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'Sunset: ${tithi?.sunset ?? 'N/A'}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
