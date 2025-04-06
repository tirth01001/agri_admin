



import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/auth/login/login.dart';
import 'package:flutter_dashboard/firebase/firebase_service.dart';
import 'package:flutter_dashboard/firebase/shared_pref_service.dart';
import 'package:flutter_dashboard/model/auth_model.dart';
import 'package:flutter_dashboard/screens/home/home.dart';
import 'package:flutter_dashboard/screens/tabbar/tabbar.dart';


AuthModel globalAuthModel = AuthModel.test();

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {

  Future<bool> initApplication() async {
    try{
      AuthModel temp = await SharedPrefService.service.userLogData;
      print(temp.logId);
      if(temp.logId.isNotEmpty){
        // globalAuthModel = await FirebaseService.service.init(temp.logId);
        globalAuthModel = temp;
        return true;
      }
    }catch(e){
      print(e.toString());
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 1), ()=> Navigator)
    init();
  }


  void init() async {
    bool value = await initApplication();
    print(value);
    if(value){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const FRTabbarScreen()), (route)=>false);
    }else{
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route)=>false);
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
      // body: FutureBuilder<bool>(
      //   future: initApplication(),
      //   builder: (query,snapshot){
          
      //     if(snapshot.connectionState == ConnectionState.waiting){

      //       return const Center(child: CircularProgressIndicator());
      //     }

      //     if(!snapshot.hasData){
      //       print(snapshot.data.toString());
      //       if(snapshot.data != null && !snapshot.data!){
      //         Timer(const Duration(seconds: 1), ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen(title: "")), (route)=>false));
      //         return const Center(child: CircularProgressIndicator());
      //       }else{
      //         Timer(const Duration(seconds: 1), ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route)=>false));
      //         return const Center(child: CircularProgressIndicator());
      //       }
      //     }

      //     return const Center(child: CircularProgressIndicator());
      //   }
      // ),
    );
  }
}