class LiteralResult {
  final String classification;
  final String meaning;
  final String why;
  final String suggestedUnderstandingOrReply;

  LiteralResult({
    required this.classification,
    required this.meaning,
    required this.why,
    required this.suggestedUnderstandingOrReply,
  });

  factory LiteralResult.fromJson(Map<String, dynamic> json) {
    return LiteralResult(
      classification: json['classification'] as String,
      meaning: json['meaning'] as String,
      why: json['why'] as String,
      suggestedUnderstandingOrReply:
          json['suggestedUnderstandingOrReply'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'classification': classification,
      'meaning': meaning,
      'why': why,
      'suggestedUnderstandingOrReply': suggestedUnderstandingOrReply,
    };
  }
}
