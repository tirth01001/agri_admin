import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_dashboard/widget/input.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class EmailRecoveryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(Icons.lock_reset, size: 80, color: Colors.blueAccent),
            ),
            SizedBox(height: 20),
            Text(
              "Forgot your password?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Don't worry! Enter your registered email below and we'll send you a link to reset your password.",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 30),
            InputField(
              prefix: Icon(Icons.mail),
              hint: "Email",
            ),
            SizedBox(height: 20),
            
            Button(
              width: maxW,
              height: 50,
              prefixIcon: Icon(IconlyBold.send,color: Colors.white,),
              text: "Send Reset Link",
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Make sure to check your spam folder if you don't receive an email.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
