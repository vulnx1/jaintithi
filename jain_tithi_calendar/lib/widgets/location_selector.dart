import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationSelector extends StatefulWidget {
  final Function(String country, String state) onLocationSelected;

  const LocationSelector({super.key, required this.onLocationSelected});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  String? _selectedCountry;
  String? _selectedState;
  bool _usingDeviceLocation = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getDeviceLocation();
  }

  Future<void> _getDeviceLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _isLoading = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          setState(() {
            _selectedCountry = place.country;
            _selectedState = place.administrativeArea;
            _usingDeviceLocation = true;
            _isLoading = false;
          });
          widget.onLocationSelected(_selectedCountry!, _selectedState!);
        }
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint("Location error: $e");
    }
  }

  void _selectManualLocation() {
    String? manualCountry;
    String? manualState;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Select Location"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Country'),
              onChanged: (value) => manualCountry = value.trim(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'State'),
              onChanged: (value) => manualState = value.trim(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if ((manualCountry?.isNotEmpty ?? false) && (manualState?.isNotEmpty ?? false)) {
                setState(() {
                  _selectedCountry = manualCountry;
                  _selectedState = manualState;
                  _usingDeviceLocation = false;
                });
                widget.onLocationSelected(manualCountry!, manualState!);
                Navigator.pop(context);
              }
            },
            child: const Text("Select"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locationText = _isLoading
        ? 'Detecting location...'
        : (_selectedState != null && _selectedCountry != null)
            ? 'Location: $_selectedState, $_selectedCountry (${_usingDeviceLocation ? "Device" : "Manual"})'
            : 'Location not available';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locationText),
        TextButton(
          onPressed: _selectManualLocation,
          child: const Text("Change Location"),
        ),
      ],
    );
  }
}
