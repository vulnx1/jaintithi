import 'package:flutter/material.dart';
import 'pages/calendar_page.dart';

void main() {
  runApp(const JainTithiCalendarApp());
}

class JainTithiCalendarApp extends StatelessWidget {
  const JainTithiCalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jain Tithi Calendar',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const CalendarPage(),
    );
  }
}