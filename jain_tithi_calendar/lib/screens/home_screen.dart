import 'package:flutter/material.dart';
import '../services/sunrise_sunset_service.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  String? sunrise;
  String? sunset;
  String? error;

  void fetchData() async {
    try {
      final result = await SunriseSunsetService.getSunriseSunsetByCity(_controller.text);
      setState(() {
        sunrise = result['sunrise'].toString();
        sunset = result['sunset'].toString();
        error = null;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        sunrise = null;
        sunset = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sunrise & Sunset Finder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetchData,
              child: Text('Get Sunrise & Sunset'),
            ),
            SizedBox(height: 24),
            if (sunrise != null) Text('🌅 Sunrise: $sunrise'),
            if (sunset != null) Text('🌇 Sunset: $sunset'),
            if (error != null) Text('❌ Error: $error'),
          ],
        ),
      ),
    );
  }
}
