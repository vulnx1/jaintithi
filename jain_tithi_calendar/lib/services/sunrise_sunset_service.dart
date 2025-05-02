class SunriseSunsetService {
  static DateTime calculateSunrise(DateTime date) {
    return DateTime(date.year, date.month, date.day, 6, 0); // placeholder 6:00 AM
  }

  static DateTime calculateSunset(DateTime date) {
    return DateTime(date.year, date.month, date.day, 18, 30); // placeholder 6:30 PM
  }
}