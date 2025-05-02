import '../models/daily_tithi.dart';

class TithiService {
  static Future<Map<DateTime, DailyTithi>> fetchTithiForMonth(DateTime month) async {
    final data = <DateTime, DailyTithi>{};
    final first = DateTime(month.year, month.month, 1);
    final last = DateTime(month.year, month.month + 1, 0);
    final tithis = ["Pratipada", "Dwitiya", "Tritiya", "Chaturthi", "Panchami"];

    for (int i = 0; i < last.day; i++) {
      final day = first.add(Duration(days: i));
      final tithi = tithis[i % tithis.length];
      final isShubh = i % 5 == 0; // dummy logic
      data[day] = DailyTithi(date: day, tithiName: tithi, isShubhDin: isShubh);
    }

    return data;
  }
}