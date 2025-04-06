

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/firebase/firebase_service.dart';
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

class ProfileSetupScreen extends StatelessWidget {

  final AuthProvider provider;
  const ProfileSetupScreen({super.key,required this.provider});

   void _start(BuildContext context){
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(),));    
  }


  void _stop(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Profile Setup", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Add more details about yourself", style: TextStyle(fontSize: 18, color: Colors.grey)),
              SizedBox(height: 30),
              InputField(
                prefix: Icon(IconlyLight.call),
                hint: "Phone Number",
                controller: provider.phone,
              ),
              SizedBox(height: 15),
              InputField(
                prefix: Icon(IconlyLight.home),
                hint: "Address",
                controller: provider.address,
              ),
              SizedBox(height: 20),
              Button(
                onTap: () async {

                  AuthModel createAccount = AuthModel.empty(
                    address: provider.address.text,
                    email: provider.email.text,
                    mobile: provider.phone.text,
                    name: provider.fullName.text
                  );
                 
                  _start(context);  
                  AuthModel model = await FirebaseService.service.register(
                    createAccount,
                    provider.password.text
                  );
                  _stop(context);

                  if(!model.isModelEmpty){
                    globalAuthModel = model;
                    SharedPrefService.service.saveUserLogData(globalAuthModel);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const FRTabbarScreen()),(rout)=>false);
                  }

                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const FRTabbarScreen()), (route) => false);
                  
                },
                width: maxW,
                height: 50,
                prefixIcon: const Icon(IconlyBold.arrowRightCircle,color: Colors.white,),
                text: "Complete Setup",
              ),
            ],
          ),
        ),
      ),
    );
  }
}