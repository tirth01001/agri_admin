import 'package:flutter/material.dart';
import 'package:flutter_dashboard/auth/login/forgot_password.dart';
import 'package:flutter_dashboard/auth/signup/signup.dart';
import 'package:flutter_dashboard/firebase/firebase_service.dart';
import 'package:flutter_dashboard/firebase/loading.dart';
import 'package:flutter_dashboard/firebase/shared_pref_service.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/model/auth_model.dart';
import 'package:flutter_dashboard/provider/auth_provider.dart';
import 'package:flutter_dashboard/screens/home/home.dart';
import 'package:flutter_dashboard/screens/tabbar/tabbar.dart';
import 'package:flutter_dashboard/splesh_screen.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_dashboard/widget/input.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({super.key});

  void _start(BuildContext context){
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(),));    
  }


  void _stop(BuildContext context) => Navigator.pop(context);


  @override
  Widget build(BuildContext context) {

    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();

    final AuthProvider provider = AuthProvider();

    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome Back!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Login to your account", style: TextStyle(fontSize: 18, color: Colors.grey)),
              SizedBox(height: 30),
              InputField(
                prefix: Icon(Icons.email),
                hint: "Email",
                controller: _email,
              ),
              SizedBox(height: 15),
              InputField(
                prefix: Icon(Icons.lock),
                hint: "Password",
                password: true,
                controller: _password,
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                  },
                  child: Text("Forgot Password?"),
                ),
              ),
              SizedBox(height: 20),
              Button(
                width: maxW,
                height: 50,
                prefixIcon: Icon(IconlyBold.login,color: Colors.white,),
                text: "Login",
                onTap: () async {


                  _start(context);
                  List<dynamic> data = await FirebaseService.service.login(_email.text,_password.text);
                  _stop(context);

                  if(data.isNotEmpty && data.length == 1){
                    AuthModel model = data.first;
                    if(!model.isModelEmpty){
                      globalAuthModel = model;
                      SharedPrefService.service.saveUserLogData(model);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const FRTabbarScreen()),(route)=>false);
                    }
                  }else if(data.length == 2){

                    String error = data[1];
                    error = error.replaceAll("Exception:","");
                    // error = error.substring(error.indexOf(":",error.length));
                    showDialog(
                      context: context, 
                      builder: (context){
                        return AlertDialog(
                          content: Container(
                            height: 100,
                            child: Center(
                              child: Text(error),
                            ),
                          ),
                        );
                      }
                    );
                    // if(error.contains("Password dose")){


                    // }else if(error.contains("Email")){

                    // }else if(error.contains("Invalid Email")){

                    // }

                  }

      
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                    },
                    child: Text("Sign Up"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}