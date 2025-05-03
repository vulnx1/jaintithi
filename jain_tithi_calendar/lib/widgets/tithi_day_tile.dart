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
    final bool isShubhDin = tithi?.shubhDin ?? false;
    final String tithiName = tithi?.tithiName ?? '';

    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: isShubhDin ? Colors.green.shade100 : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          tithiName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isShubhDin ? Colors.green.shade800 : Colors.black,
          ),
        ),
      ),
    );
  }
}
