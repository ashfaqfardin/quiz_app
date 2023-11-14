import 'package:flutter/material.dart';
import 'package:ccds_quiz_app_v2/pages/login_page.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}