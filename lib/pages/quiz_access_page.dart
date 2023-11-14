import 'package:flutter/material.dart';
import 'package:ccds_quiz_app_v2/pages/quiz_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class QuizAccessPage extends StatefulWidget {
  final String userType;
  final String username;
  final String password;

  const QuizAccessPage({super.key, required this.userType, required this.username, required this.password});

  @override
  State<QuizAccessPage> createState() => _QuizAccessPageState();
}

class _QuizAccessPageState extends State<QuizAccessPage> {
  final List<String> _quizzes = ['Quiz 1', 'Quiz 2', 'Quiz 3'];
 // Dummy list of quizzes

  Future<void> _signOut() async {
    // Navigate user back to the login page
    clearSessionData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/ccds2.png',
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
              onPressed: _signOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
          )
        ],
      ),
      backgroundColor: const Color(0xffEEF1F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Access your quiz",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome, ${widget.username}!',
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Choose a Quiz:',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _quizzes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ListTile(
                        tileColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        title: Text(
                          _quizzes[index],
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuizPage(
                                userType: widget.userType,
                                username: widget.username,
                                password: widget.password,
                                quizName: _quizzes[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearSessionData() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('username');
    prefs.remove('password');
  }
}