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

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        setState(() {
          _country = placemarks[0].country;
          _state = placemarks[0].administrativeArea;
          _latitude = position.latitude;
          _longitude = position.longitude;
        });
        widget.onLocationSelected(_country!, _state!, _latitude!, _longitude!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Location: ${_state ?? '...'}, ${_country ?? '...'}"),
        TextButton(
          onPressed: _fetchLocation,
          child: const Text("Refresh Location"),
        )
      ],
    );
  }
}