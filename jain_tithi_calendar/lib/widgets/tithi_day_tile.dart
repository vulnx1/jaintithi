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
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: tithi?.shubhDin ?? false ? Colors.green.shade100 : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          tithi?.tithiName ?? '',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: tithi?.shubhDin ?? false ? Colors.green : Colors.black,
          ),
        ),
      ),
    );
  }
}
