import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/daily_tithi.dart';
import '../services/tithi_service.dart';
import '../widgets/tithi_day_tile.dart';
import 'day_detail_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, DailyTithi> _tithiData = {};

  @override
  void initState() {
    super.initState();
    _loadTithiData(_focusedDay);
  }

  void _loadTithiData(DateTime month) async {
    final data = await TithiService.fetchTithiForMonth(month);
    setState(() => _tithiData.addAll(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jain Tithi Calendar')),
      body: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DayDetailPage(
                date: selectedDay,
                tithi: _tithiData[selectedDay],
              ),
            ),
          );
        },
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, _) => TithiDayTile(
            date: day,
            tithi: _tithiData[day],
          ),
        ),
      ),
    );
  }
}