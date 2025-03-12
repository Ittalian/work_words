import 'package:flutter/material.dart';
import 'package:work_words/views/pages/home/home.dart';
import 'package:work_words/views/pages/memorize/memorize.dart';
import 'package:work_words/views/pages/memorize/memorize_start.dart';
import 'package:work_words/views/pages/memorize/result_memorize.dart';

class Routes {
  static const String home = 'home';
  static const String memorizeStart = 'memorize_start';
  static const String memorize = 'memorize';
  static const String resultMemorize = 'result_memorize';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const Home(),
        );
      case memorizeStart:
        final memorizeStartOptions = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => MemorizeStart(
            categories: memorizeStartOptions['categories'],
          ),
        );
      case memorize:
        final memorizeOptions = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => Memorize(
            words: memorizeOptions['words'],
            questionCount: memorizeOptions['questionCount'],
          ),
        );
      case resultMemorize:
        final resultMemorizeOptions = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => ResultMemorize(
            memorizeWords: resultMemorizeOptions['memorizeWords'],
            correctCount: resultMemorizeOptions['correctCount'],
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('${settings.name}は存在しません',
                  style: const TextStyle(fontSize: 20)),
            ),
          ),
        );
    }
  }
}
