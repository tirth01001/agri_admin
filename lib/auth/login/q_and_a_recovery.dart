import 'package:flutter/material.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_dashboard/widget/input.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class SecurityQuestionRecoveryScreen extends StatelessWidget {
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
              child: Icon(Icons.security, size: 80, color: Colors.blueAccent),
            ),
            SizedBox(height: 20),
            Text(
              "Answer your security question",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Provide the answer to the security question you set up earlier. If your answer is correct, you'll be able to reset your password.",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 30),
            InputField(
              prefix: Icon(Icons.mail),
              hint: "Your First Pet's Name?",
            ),
            SizedBox(height: 20),
            Button(
              width: maxW,
              height: 50,
              prefixIcon: Icon(IconlyBold.tickSquare,color: Colors.white,),
              text: "Verify Answer",
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Make sure to enter the exact answer you set up.",
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
