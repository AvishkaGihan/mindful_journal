import 'package:firebase_ai/firebase_ai.dart';

/// Thin wrapper around Firebase AI Logic (Gemini 2.5 Flash)
/// Drop-in replacement for the old OpenAIService
class AIService {
  late final GenerativeModel _model;

  AIService() {
    // Firebase must be initialized before we build the model.
    // main.dart already does that, so we are safe.
    _model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.5-flash', // ← current, non-retired model
    );
  }

  /// Generate a compassionate insight for a journal entry.
  /// Keeps the **exact same method signature** the rest of your code expects.
  Future<String> generateInsight(String entryContent) async {
    try {
      final prompt =
          '''
You are a compassionate journal companion.
Analyse this entry and give:
1. the overall mood/emotion
2. a brief, supportive insight
3. an encouraging message

Keep it under 100 words and be empathetic.

Journal Entry:
$entryContent
''';

      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim() ?? 'No insight returned.';
    } catch (e) {
      throw Exception('Gemini insight failed: $e');
    }
  }
}
