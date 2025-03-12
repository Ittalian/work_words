import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:work_words/config/routes.dart';
import 'package:work_words/views/pages/home/home.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
