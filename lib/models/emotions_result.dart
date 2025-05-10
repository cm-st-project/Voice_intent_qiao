class EmotionResult {
  final List<EmotionScore> topEmotions;
  final TimeStamp timestamp;
  final List<EmotionScore> rawEmotions;

  EmotionResult({
    required this.topEmotions,
    required this.timestamp,
    required this.rawEmotions,
  });

  factory EmotionResult.fromJson(Map<String, dynamic> json) {
    return EmotionResult(
      topEmotions:
          (json['top_emotions'] as List)
              .map((e) => EmotionScore.fromJson(e))
              .toList(),
      timestamp: TimeStamp.fromJson(json['timestamp']),
      rawEmotions:
          (json['raw_emotions'] as List)
              .map((e) => EmotionScore.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'top_emotions': topEmotions.map((e) => e.toJson()).toList(),
      'timestamp': timestamp.toJson(),
      'raw_emotions': rawEmotions.map((e) => e.toJson()).toList(),
    };
  }
}

class EmotionScore {
  final String name;
  final double score;
  EmotionScore({required this.name, required this.score});

  factory EmotionScore.fromJson(Map<String, dynamic> json) {
    return EmotionScore(
      name: json['name'] as String,
      score: (json['score'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'score': score};
  }
}

class TimeStamp {
  final double begin;
  final double end;

  TimeStamp({required this.begin, required this.end});

  factory TimeStamp.fromJson(Map<String, dynamic> json) {
    return TimeStamp(
      begin: (json['begin'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'begin': begin, 'end': end};
  }
}
