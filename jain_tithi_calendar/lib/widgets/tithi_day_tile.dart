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

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
