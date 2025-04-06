

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/auth/signup/profile_setup.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/provider/auth_provider.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_dashboard/widget/input.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

final AuthProvider authProvider = AuthProvider();
class SignUpScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: authProvider,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Create Account", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Enter your details", style: TextStyle(fontSize: 18, color: Colors.grey)),
              SizedBox(height: 30),
              InputField(
                prefix: Icon(Icons.person),
                hint: "Full Name",
                controller: authProvider.fullName,
              ),
              SizedBox(height: 15),
              InputField(
                prefix: Icon(Icons.email),
                hint: "Email",
                controller: authProvider.email,
              ),
              SizedBox(height: 15),
              InputField(
                prefix: Icon(Icons.lock),
                hint: "Password",
                controller: authProvider.password,
                password: true,
              ),
              SizedBox(height: 20),
              Button(
                onTap: (){
          
                  if(authProvider.fullName.text.isEmpty){
                    showErrorDialog(context, "Please enter your full name");
                    return;
                  }else if(authProvider.email.text.isEmpty){
                    showErrorDialog(context, "Please enter your email address");
                    return;
                  }else if(authProvider.password.text.isEmpty){
                    showErrorDialog(context, "Please create your password !");
                    return;
                  }
          
                  if(!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(authProvider.email.text)){
                    showErrorDialog(context, "Please enter valid email !");
                    return;
                  }
          
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSetupScreen(
                    provider: authProvider,
                  )));
                },
                width: maxW,
                height: 50,
                prefixIcon: Icon(IconlyBold.arrowRightCircle,color: Colors.white,),
                text: "Sign Up",
              ),
            ],
          ),
        ),
      ),
    );
  }


  void showErrorDialog(BuildContext context,String messgae){
    showDialog(
      context: context, 
      builder: (context)=> AlertDialog(
        content: Container(
          height: 100,
          child: Center(
            child: Text(messgae),
          ),
        ),
      ),
    );
  }

}
