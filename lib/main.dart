import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/constant/responsive.dart';
import 'package:flutter_dashboard/firebase_options.dart';
import 'package:flutter_dashboard/routes.dart';
import 'package:flutter_dashboard/screens/tabbar/tabbar.dart';
import 'package:flutter_dashboard/theme.dart';

void main()  async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const FreshBuyerApp());
}

double maxW=0.0,maxH=0.0;

class FreshBuyerApp extends StatelessWidget {
  const FreshBuyerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    maxW = MediaQuery.of(context).size.width;
    maxH = MediaQuery.of(context).size.height;
    
    Responsive.init(context);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fresh-Buyer',
      theme: appTheme(),
      routes: routes,
      initialRoute: '/sp',
      home: const FRTabbarScreen(),
    );
  }
}
