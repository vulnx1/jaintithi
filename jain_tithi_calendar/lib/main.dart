// ---------------------- main.dart ----------------------
import 'package:flutter/material.dart';
import 'pages/calendar_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jain Tithi Calendar',
      home: const CalendarPage(),
    );
  }
}