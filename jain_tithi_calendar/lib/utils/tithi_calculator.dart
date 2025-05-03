String calculateTithi(double sunLongitude, double moonLongitude) {
  double diff = moonLongitude - sunLongitude;
  if (diff < 0) diff += 360;

  double tithiDecimal = diff / 12;
  int tithiNumber = tithiDecimal.ceil();

  String paksha = tithiNumber <= 15 ? 'Shukla' : 'Krishna';
  int tithiIndex = tithiNumber <= 15 ? tithiNumber : tithiNumber - 15;

  List<String> tithiNames = [
    'Pratipada', 'Dvitiya', 'Tritiya', 'Chaturthi', 'Panchami', 'Shashthi',
    'Saptami', 'Ashtami', 'Navami', 'Dashami', 'Ekadashi', 'Dwadashi',
    'Trayodashi', 'Chaturdashi', 'Purnima/Amavasya'
  ];

  String tithiName = tithiNames[tithiIndex - 1];

  return "$paksha Paksha - $tithiName (Tithi $tithiNumber)";
}
