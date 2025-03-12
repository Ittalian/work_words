import 'package:work_words/models/word.dart';

class MemorizeWord {
  final Word word;
  final String answer;
  final String? correctAnswer;

  const MemorizeWord({
    required this.word,
    required this.answer,
    this.correctAnswer,
  });
}
