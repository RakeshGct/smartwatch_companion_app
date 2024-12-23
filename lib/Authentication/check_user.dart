import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_sync/Authentication/login_page.dart';
import 'package:fit_sync/Screens/dashboard.dart';
import 'package:fit_sync/main.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    // Use FutureBuilder to handle the asynchronous checkuser function
    return FutureBuilder(
      future: checkUser(),  // Call your async function here
      builder: (context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());  // Show loading indicator while waiting
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));  // Handle error state
        } else if (snapshot.hasData) {
          return snapshot.data!;  // Show the widget (HomePage or LoginPage)
        } else {
          return Center(child: Text("No user found."));  // Fallback in case of no data
        }
      },
    );
  }

  // Check if the user is already signed in or not
  Future<Widget> checkUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return MainScreen();  // User is logged in, navigate to MainScreen
    } else {
      return LoginPage();  // User is not logged in, show LoginPage
    }
  }
}
