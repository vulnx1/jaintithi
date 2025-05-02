import 'package:flutter/material.dart';
import '../models/daily_tithi.dart';

class TithiDayTile extends StatelessWidget {
  final DateTime date;
  final DailyTithi? tithi;

  const TithiDayTile({super.key, required this.date, this.tithi});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${date.day}"),
          if (tithi != null)
            Text(
              tithi!.tithiName,
              style: TextStyle(
                fontSize: 10,
                color: tithi!.isShubhDin ? Colors.green : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}