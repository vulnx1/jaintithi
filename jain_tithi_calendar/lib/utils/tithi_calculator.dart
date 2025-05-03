/// Calculates the Tithi (lunar day) based on the sun and moon longitudes.
///
/// [sunLongitude] and [moonLongitude] should be in degrees.
/// Returns a formatted string indicating the Paksha and Tithi name.
String calculateTithi(double sunLongitude, double moonLongitude) {
  // Normalize the difference to 0–360 degrees
  double diff = moonLongitude - sunLongitude;
  if (diff < 0) diff += 360;

  // Each Tithi is 12° apart in the ecliptic longitude difference
  double tithiDecimal = diff / 12;
  int tithiNumber = tithiDecimal.ceil().clamp(1, 30); // Clamp to 1–30

  // Determine Paksha and Tithi Index (1–15)
  String paksha = tithiNumber <= 15 ? 'Shukla' : 'Krishna';
  int tithiIndex = tithiNumber <= 15 ? tithiNumber : tithiNumber - 15;

  // List of 15 unique Tithis
  const List<String> tithiNames = [
    'Pratipada', 'Dvitiya', 'Tritiya', 'Chaturthi', 'Panchami', 'Shashthi',
    'Saptami', 'Ashtami', 'Navami', 'Dashami', 'Ekadashi', 'Dwadashi',
    'Trayodashi', 'Chaturdashi', 'Purnima/Amavasya'
  ];

  final String tithiName = tithiNames[(tithiIndex - 1).clamp(0, 14)];

  return '$paksha Paksha - $tithiName (Tithi $tithiNumber)';
}
