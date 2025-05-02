class CustomDateUtils {
  static String formatDate(DateTime date) =>
      "${date.day}/${date.month}/${date.year}";

  static String formatTime(DateTime time) =>
      "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

  static Map<String, DateTime> calculateRitualTimings(DateTime sunrise, DateTime sunset) {
    final duration = sunset.difference(sunrise);
    final prahar = duration.inMinutes ~/ 4;

    return {
      "Navkarshi": sunrise.add(const Duration(minutes: 48)),
      "Porsi": sunrise.add(Duration(minutes: prahar * 1)),
      "Sadh Porsi": sunrise.add(Duration(minutes: (prahar * 1.5).round())),
      "Purimaddha": sunrise.add(Duration(minutes: prahar * 2)),
      "Avaddha": sunrise.add(Duration(minutes: prahar * 3)),
    };
  }
}
