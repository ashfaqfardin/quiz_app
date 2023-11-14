import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final String userType;
  final String username;
  final String password;
  final String quizName;

  const QuizPage({Key? key, required this.userType, required this.username, required this.password, required this.quizName}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  late String _selectedAnswer;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['London', 'Paris', 'Berlin', 'Madrid'],
      'correctAnswer': 'Paris',
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Mars', 'Jupiter', 'Venus', 'Mercury'],
      'correctAnswer': 'Mars',
    },
    // Add more questions here...
  ];

  @override
  void initState() {
    super.initState();
    _selectedAnswer = _questions[_currentQuestionIndex]['options'][0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/ccds2.png',
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xffEEF1F3),
      body: _buildQuizBody(),
    );
  }

  Widget _buildQuizBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              _buildQuizHeader(),
              _buildQuestion(),
              _buildOptions(),
              _buildNextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizHeader() {
    return Text(
      widget.quizName,
      style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700, color: Colors.black),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20.0),
        Text(
          'Question ${_currentQuestionIndex + 1}:',
          style: const TextStyle(fontSize: 20.0, color: Colors.black),
        ),
        const SizedBox(height: 10.0),
        Text(
          _questions[_currentQuestionIndex]['question'],
          style: const TextStyle(fontSize: 20.0, color: Colors.black),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _questions[_currentQuestionIndex]['options'].map<Widget>((option) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedAnswer = option;
              });
            },
            child: ListTile(
              tileColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              title: Text(
                option,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: Icon(_selectedAnswer == option ? Icons.check : Icons.circle),
            ),
          ),
        );
      }).toList(),
    );
  }




  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: _submitAnswer,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black, shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: const Text('Next'),
      ),
    );
  }


  void _submitAnswer() {
    String correctAnswer = _questions[_currentQuestionIndex]['correctAnswer'];
    bool isCorrect = (_selectedAnswer == correctAnswer);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200, // You can adjust this value as needed
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(isCorrect ? 'Correct!' : 'Incorrect!',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text(isCorrect ? 'Your answer is correct.' : 'Your answer is incorrect.',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _navigateToNextQuestionOrFinishQuiz();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  void _navigateToNextQuestionOrFinishQuiz() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = _questions[_currentQuestionIndex]['options'][0];
        Navigator.pop(context);
      });
    } else {
      Navigator.pop(context); // Close the dialog
      Navigator.pop(context); // Go back to the quiz access page
    }
  }
}
