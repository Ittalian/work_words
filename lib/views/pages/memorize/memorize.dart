import 'package:flutter/material.dart';
import 'package:work_words/config/routes.dart';
import 'package:work_words/models/memorize_word.dart';
import 'package:work_words/models/word.dart';
import 'package:work_words/views/widgets/base/base_image_container.dart';
import 'package:work_words/views/widgets/memorize/memorize_selection.dart';

class Memorize extends StatefulWidget {
  final List<Word> words;
  final int questionCount;

  const Memorize({
    super.key,
    required this.words,
    required this.questionCount,
  });

  @override
  State<Memorize> createState() => MemorizeState();
}

class MemorizeState extends State<Memorize> {
  int questionIndex = 0;
  int correctCount = 0;
  bool answeredAll = false;
  List<Word> questionWords = [];
  List<MemorizeWord> memorizeWords = [];

  @override
  void initState() {
    super.initState();
    getQuestionWords();
  }

  List<String> getSuggestions() {
    List<String> suggestions =
        questionWords.map((word) => word.meaning).toList();
    suggestions = suggestions.toSet().toList();
    String correctAnswer = questionWords[questionIndex].meaning;
    suggestions.removeWhere(
        (answer) => questionWords[questionIndex].meaning == answer);
    suggestions.shuffle();
    List<String> targetSuggestions = suggestions.take(3).toList();
    targetSuggestions.add(correctAnswer);
    targetSuggestions.shuffle();

    return targetSuggestions;
  }

  void getQuestionWords() {
    questionWords = List<Word>.from(widget.words);
    questionWords.shuffle();
    if (widget.questionCount < questionWords.length) {
      questionWords = questionWords.take(widget.questionCount).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseImageContainer(
      imagePath: 'images/memorize_selection.jpg',
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        body: PopScope(
          canPop: false,
          child: MemorizeSelection(
            word: questionWords[questionIndex],
            suggestions: getSuggestions(),
            onPressedAnswer: (answer) => countCorrect(answer),
            finishMemorize: () => moveResultMemorize(),
            answeredAll: answeredAll,
          ),
        ),
      ),
    );
  }

  void nextQuestion() {
    if (questionIndex < questionWords.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      setState(() {
        answeredAll = true;
      });
    }
  }

  void setCorrect(Word targetWord, String answer) {
    setState(() {
      correctCount++;
      memorizeWords.add(MemorizeWord(
        word: targetWord,
        answer: answer,
      ));
    });
    showCorrectMessage(context);
  }

  void setInCorrect(Word targetWord, String answer) {
    setState(() {
      memorizeWords.add(MemorizeWord(
        word: targetWord,
        answer: answer,
        correctAnswer: targetWord.meaning,
      ));
    });
    showInCorrectErrorMessage(context);
  }

  void countCorrect(String answer) {
    final targetWord = questionWords[questionIndex];
    if (targetWord.meaning == answer) {
      setCorrect(targetWord, answer);
    } else {
      setInCorrect(targetWord, answer);
    }
    nextQuestion();
  }

  void moveResultMemorize() {
    Navigator.pushNamed(
      context,
      Routes.resultMemorize,
      arguments: {
        'memorizeWords': memorizeWords,
        'correctCount': correctCount,
      },
    );
  }

  showCorrectMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('正解！'),
        backgroundColor: Colors.blue,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.black,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  showInCorrectErrorMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('不正解'),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }
}
