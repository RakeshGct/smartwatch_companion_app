
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_sync/Authentication/uihelper.dart';
import 'package:flutter/material.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  TextEditingController emailController = new TextEditingController();

  //forget password function
  forgetpassword(String email) async{
    if(email == "") {
      return Uihelper.CustomAlertBox(context, "Enter an email to reset password");
    } else {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Uihelper.CustomTextField(emailController, "Email", Icons.mail_outline_outlined, false),
          SizedBox(height: 20,),
          Uihelper.CustomButton(() {
            forgetpassword(emailController.text.toString());
          }, "Reset password"),

        ],
      ),
    );
  }
}
