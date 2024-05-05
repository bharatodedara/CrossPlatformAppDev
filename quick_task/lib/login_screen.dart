// login_screen.dart

import 'package:flutter/material.dart';
import '/authentication_service.dart';
import 'task_management_screen.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatelessWidget {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    String username = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // username field
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
              onChanged: (value) => username = value,
            ),
            // Password field
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) => password = value,
            ),
            // Login button
            ElevatedButton(
              onPressed: () async {
                final response =
                    await AuthenticationService.logIn(username, password);
                if (response.success) {
                  // Navigate to task management screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskManagementScreen(),
                    ),
                  );
                } else {
                  // Show error message
                  // Signup failed
                  /* setState(() {
                    _isLoading = false;
                  });*/
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(response.error!.message),
                    backgroundColor: Colors.red,
                  ));

                  print(response.error!.message);
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20.0),

            // Add SignUp button
            ElevatedButton(
              onPressed: () {
                // Navigate to signup screen when SignUp button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SignUpScreen(), // Navigate to SignUpScreen
                  ),
                );
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
