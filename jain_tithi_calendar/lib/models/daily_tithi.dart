/// A model representing Tithi (lunar day) information for a specific date.
class DailyTithi {
  /// The date of the Tithi.
  final DateTime date;

  /// The name of the Tithi (e.g., "Pratipada", "Panchami").
  final String tithiName;

  /// Whether this day is considered a "Shubh Din" (auspicious day).
  final bool shubhDin;

  /// Sunrise time formatted as HH:mm.
  final String sunrise;

  /// Sunset time formatted as HH:mm.
  final String sunset;

  const DailyTithi({
    required this.date,
    required this.tithiName,
    required this.shubhDin,
    required this.sunrise,
    required this.sunset,
  });

  @override
  String toString() {
    return 'DailyTithi(date: $date, tithiName: $tithiName, shubhDin: $shubhDin, sunrise: $sunrise, sunset: $sunset)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyTithi &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          tithiName == other.tithiName &&
          shubhDin == other.shubhDin &&
          sunrise == other.sunrise &&
          sunset == other.sunset;

  @override
  int get hashCode =>
      date.hashCode ^
      tithiName.hashCode ^
      shubhDin.hashCode ^
      sunrise.hashCode ^
      sunset.hashCode;
}
