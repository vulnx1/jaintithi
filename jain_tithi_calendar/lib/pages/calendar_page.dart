import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/daily_tithi.dart';
import '../services/tithi_service.dart';
import '../widgets/tithi_day_tile.dart';
import '../widgets/location_selector.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  final Map<DateTime, DailyTithi> _tithiData = {};
  double? _latitude, _longitude;
  bool _isLoading = false;
  String? _error;

  DateTime _normalize(DateTime dt) => DateTime.utc(dt.year, dt.month, dt.day);

  void _loadTithiData(DateTime month) async {
    if (_latitude == null || _longitude == null) return;
    
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    try {
      final data = await TithiService.fetchTithiForMonth(
        DateTime(month.year, month.month),
        latitude: _latitude!,
        longitude: _longitude!
      );
      
      setState(() {
        _tithiData.clear();
        data.forEach((key, value) => _tithiData[_normalize(key)] = value);
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jain Tithi Calendar')),
      body: Column(
        children: [
          LocationSelector(
            onLocationSelected: (country, state, lat, lon) {
              setState(() {
                _latitude = lat;
                _longitude = lon;
              });
              _loadTithiData(_focusedDay);
            },
          ),
          if (_isLoading) const LinearProgressIndicator(),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Error: $_error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: TableCalendar(
              firstDay: DateTime.utc(2020),
              lastDay: DateTime.utc(2030),
              focusedDay: _focusedDay,
              onPageChanged: (focusedDay) {
                setState(() => _focusedDay = focusedDay);
                _loadTithiData(focusedDay);
              },
              selectedDayPredicate: (day) => false,
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
