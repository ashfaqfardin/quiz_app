import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final String userType;
  final String username;

  const DashboardPage({super.key, required this.userType, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, $username!',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              'User Type: $userType',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the login page
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}