import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_sync/Authentication/login_page.dart';
import 'package:fit_sync/Authentication/uihelper.dart';
import 'package:fit_sync/Screens/dashboard.dart';
import 'package:fit_sync/main.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  //function for sign up
  signUp(String email, String password) async {
    if(email == "" || password == "") {
      return Uihelper.CustomAlertBox(context, "Please enter required fields",);
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).
        then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
        });
      }
      on FirebaseAuthException catch(ex) {
        return Uihelper.CustomAlertBox(context, ex.code.toString());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "Enter the email",
                  prefixIcon: Icon(Icons.email_outlined)
              ),
            ),
            TextField(
              controller: passController,
              decoration: InputDecoration(
                  hintText: "Enter the password",
                  prefixIcon: Icon(Icons.lock)
              ),
              obscureText: true,
            ),
            ElevatedButton(onPressed: () {
              signUp(emailController.text.toString(), passController.text.toString());
            },
                child: Text("Sign Up")),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account??"),
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                }, child: Text("Login", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),))
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }
}
