import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_sync/Authentication/forget_password.dart';
import 'package:fit_sync/Authentication/signup_page.dart';
import 'package:fit_sync/Authentication/uihelper.dart';
import 'package:fit_sync/Screens/dashboard.dart';
import 'package:fit_sync/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
    await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  //function for loging
  login(String email, String password) async {
    if(email == "" || password == "") {
      return Uihelper.CustomAlertBox(context, "Enter required fields");
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).
        then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
        });
      } on FirebaseAuthException catch(ex) {
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
                controller: emailcontroller,
                decoration: InputDecoration(
                  hintText: "Enter the email",
                  prefixIcon: Icon(Icons.email_outlined)
                ),
              ),
              TextField(
                controller: passcontroller,
                decoration: InputDecoration(
                  hintText: "Enter the password",
                  prefixIcon: Icon(Icons.lock)
                ),
                obscureText: true,
              ),
              ElevatedButton(onPressed: () {
                  login(emailcontroller.text.toString(), passcontroller.text.toString());
              },
                  child: Text("Login")),

              TextButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Forgetpassword()));
              }, child: Text("Forget Password", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
              ),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account"),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                  }, child: Text("create account", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
