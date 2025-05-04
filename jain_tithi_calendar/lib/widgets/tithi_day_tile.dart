import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Make sure to import intl package for formatting dates
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
    // Ensure we are using formatted strings for sunrise and sunset
    final sunriseTime = _formatTime(tithi?.sunrise);
    final sunsetTime = _formatTime(tithi?.sunset);

    // Example ritual calculations (make sure to use DateTime objects for calculations)
    final navkarshi = _calculateNavkarshi(tithi?.sunrise ?? DateTime.now());
    final porsi = _calculatePorsi(tithi?.sunrise ?? DateTime.now());
    final sadhPorsi = _calculateSadhPorsi(tithi?.sunrise ?? DateTime.now());
    final purimaddha = _calculatePurimaddha(tithi?.sunset ?? DateTime.now());
    final avaddha = _calculateAvaddha(tithi?.sunset ?? DateTime.now());

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

  // Utility to format the time as HH:mm
  String _formatTime(DateTime? time) {
    if (time == null) return 'N/A'; // Return 'N/A' if time is null
    return DateFormat('HH:mm').format(time); // Format DateTime to 'HH:mm' format
  }

  // Ritual time calculations (using DateTime objects for accuracy)
  String _calculateNavkarshi(DateTime sunrise) {
    final navkarshiTime = sunrise.add(const Duration(minutes: 48));
    return _formatTime(navkarshiTime);
  }

  String _calculatePorsi(DateTime sunrise) {
    final porsiTime = sunrise.add(const Duration(hours: 6));
    return _formatTime(porsiTime);
  }

  String _calculateSadhPorsi(DateTime sunrise) {
    final sadhPorsiTime = sunrise.add(const Duration(hours: 7));
    return _formatTime(sadhPorsiTime);
  }

  String _calculatePurimaddha(DateTime sunset) {
    final purimaddhaTime = sunset.add(const Duration(hours: 1));
    return _formatTime(purimaddhaTime);
  }

  String _calculateAvaddha(DateTime sunset) {
    final avaddhaTime = sunset.add(const Duration(hours: 2));
    return _formatTime(avaddhaTime);
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
                'Sunrise: ${_formatTime(tithi?.sunrise)}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'Sunset: ${_formatTime(tithi?.sunset)}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
