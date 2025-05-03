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
  final Map<DateTime, DailyTithi> _tithiData = {};
  final DateTime _firstDay = DateTime.utc(2020);
  final DateTime _lastDay = DateTime.utc(2030);

  DateTime _focusedDay = DateTime.now();
  double? _latitude, _longitude;
  bool _isLoading = false;
  String? _error;

  DateTime _normalize(DateTime dt) => DateTime.utc(dt.year, dt.month, dt.day);

  Future<void> _loadTithiData(DateTime month) async {
    if (_latitude == null || _longitude == null) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await TithiService.fetchTithiForMonth(
        DateTime(month.year, month.month),
        latitude: _latitude!,
        longitude: _longitude!,
      );

      setState(() {
        _tithiData
          ..clear()
          ..addEntries(data.entries.map((e) => MapEntry(_normalize(e.key), e.value)));
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
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
          LocationSelector(onLocationSelected: _onLocationSelected),
          if (_isLoading) const LinearProgressIndicator(),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Error: $_error', style: const TextStyle(color: Colors.red)),
            ),
          Expanded(
            child: TableCalendar(
              firstDay: _firstDay,
              lastDay: _lastDay,
              focusedDay: _focusedDay,
              onPageChanged: (day) {
                setState(() => _focusedDay = day);
                _loadTithiData(day);
              },
              selectedDayPredicate: (_) => false,
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, _) {
                  final normalized = _normalize(day);
                  return TithiDayTile(date: day, tithi: _tithiData[normalized]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
