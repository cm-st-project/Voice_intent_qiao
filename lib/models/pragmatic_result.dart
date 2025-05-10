class PragmaticResult {
  final String pragmaticUse;
  final String speakerIntent;
  final String interpretation;
  final String suggestedResponse;

  PragmaticResult({
    required this.pragmaticUse,
    required this.speakerIntent,
    required this.interpretation,
    required this.suggestedResponse,
  });

  factory PragmaticResult.fromJson(Map<String, dynamic> json) {
    return PragmaticResult(
      pragmaticUse: json['pragmatic_use'] as String,
      speakerIntent: json['speaker_intent'] as String,
      interpretation: json['interpretation'] as String,
      suggestedResponse: json['suggested_response'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'pragmatic_use': pragmaticUse,
      'speaker_intent': speakerIntent,
      'interpretation': interpretation,
      'suggested_response': suggestedResponse,
    };
  }
}
