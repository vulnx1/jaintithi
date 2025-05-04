/// Model to store ritual timings based on sunrise/sunset
class RitualTimings {
  final DateTime navkarshi;     // ~48 minutes after sunrise
  final DateTime porsi;         // Sunrise + 1 prahar
  final DateTime sadhPorsi;     // Sunrise + 1.5 prahar
  final DateTime purimaddha;    // Sunrise + 2 prahar
  final DateTime avaddha;       // Sunrise + 3 prahar

  RitualTimings({
    required this.navkarshi,
    required this.porsi,
    required this.sadhPorsi,
    required this.purimaddha,
    required this.avaddha,
  });

  /// Optional: Construct from JSON if needed later
  factory RitualTimings.fromJson(Map<String, dynamic> json) {
    return RitualTimings(
      navkarshi: DateTime.parse(json['navkarshi']),
      porsi: DateTime.parse(json['porsi']),
      sadhPorsi: DateTime.parse(json['sadh_porsi']),
      purimaddha: DateTime.parse(json['purimaddha']),
      avaddha: DateTime.parse(json['avaddha']),
    );
  }

  /// Convert to JSON for storage/caching
  Map<String, dynamic> toJson() {
    return {
      'navkarshi': navkarshi.toIso8601String(),
      'porsi': porsi.toIso8601String(),
      'sadh_porsi': sadhPorsi.toIso8601String(),
      'purimaddha': purimaddha.toIso8601String(),
      'avaddha': avaddha.toIso8601String(),
    };
  }

  @override
  String toString() {
    return '''
    RitualTimings(
      Navkarshi: $navkarshi, 
      Porsi: $porsi, 
      SadhPorsi: $sadhPorsi, 
      Purimaddha: $purimaddha, 
      Avaddha: $avaddha
    )
    ''';
  }
}
