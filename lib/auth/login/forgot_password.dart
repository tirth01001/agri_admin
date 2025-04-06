import 'package:flutter/material.dart';
import 'package:flutter_dashboard/auth/login/email_recovery.dart';
import 'package:flutter_dashboard/auth/login/q_and_a_recovery.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("How would you like to reset your password?", 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(IconlyBold.message, color: Colors.blue),
              title: Text("Reset via Email"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => EmailRecoveryScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(IconlyBold.shieldDone, color: Colors.green),
              title: Text("Answer Security Question"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SecurityQuestionRecoveryScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
} 