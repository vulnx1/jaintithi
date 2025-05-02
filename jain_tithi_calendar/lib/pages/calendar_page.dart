import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/daily_tithi.dart';
import '../services/tithi_service.dart';
import '../widgets/tithi_day_tile.dart';
import 'day_detail_page.dart';
import '../widgets/location_selector.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, DailyTithi> _tithiData = {};

  double? _latitude;
  double? _longitude;

  DateTime _normalize(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  void _loadTithiData(DateTime month) async {
    if (_latitude == null || _longitude == null) return;
    final data = await TithiService.fetchTithiForMonth(month, latitude: _latitude!, longitude: _longitude!);
    setState(() {
      _tithiData.clear();
      data.forEach((key, value) => _tithiData[_normalize(key)] = value);
    });
  }

  void _onLocationSelected(String country, String state, double lat, double lon) {
    setState(() {
      _latitude = lat;
      _longitude = lon;
    });
    _loadTithiData(_focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jain Tithi Calendar')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LocationSelector(
              onLocationSelected: _onLocationSelected,
            ),
          ),
          Expanded(
            child: TableCalendar(
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
                      tithi: _tithiData[_normalize(selectedDay)],
                    ),
                  ),
                );
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, _) => TithiDayTile(
                  date: day,
                  tithi: _tithiData[_normalize(day)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}