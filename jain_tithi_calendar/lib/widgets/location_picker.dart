import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationSelector extends StatefulWidget {
  final Function(String country, String state, double latitude, double longitude) onLocationSelected;

  const LocationSelector({super.key, required this.onLocationSelected});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  String? _country;
  String? _state;
  double? _latitude;
  double? _longitude;
  bool _isFetching = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    setState(() {
      _isFetching = true;
      _error = null;
    });

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _error = 'Location services are disabled.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        setState(() => _error = 'Location permission not granted.');
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final placemark = placemarks[0];
        setState(() {
          _country = placemark.country;
          _state = placemark.administrativeArea;
          _latitude = position.latitude;
          _longitude = position.longitude;
        });
        widget.onLocationSelected(_country!, _state!, _latitude!, _longitude!);
      }
    } catch (e) {
      setState(() => _error = 'Failed to get location: $e');
    } finally {
      setState(() => _isFetching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location: ${_state ?? 'Detecting...'}, ${_country ?? ''}',
            style: const TextStyle(fontSize: 16),
          ),
          if (_isFetching)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: LinearProgressIndicator(),
            ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(_error!, style: const TextStyle(color: Colors.red)),
            ),
          TextButton.icon(
            onPressed: _fetchLocation,
            icon: const Icon(Icons.my_location),
            label: const Text('Refresh Location'),
          ),
        ],
      ),
    );
  }
}
