import 'package:flutter/material.dart';
import 'package:flutter_dashboard/screens/home/home.dart';
import 'package:flutter_dashboard/screens/mostpopular/most_popular_screen.dart';
import 'package:flutter_dashboard/screens/profile/profile_screen.dart';
import 'package:flutter_dashboard/screens/special_offers/special_offers_screen.dart';
import 'package:flutter_dashboard/screens/test/test_screen.dart';
import 'package:flutter_dashboard/splesh_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/sp': (context) => const SpleshScreen(),
  HomeScreen.route(): (context) => const HomeScreen(title: '123'),
  MostPopularScreen.route(): (context) => const MostPopularScreen(),
  SpecialOfferScreen.route(): (context) => const SpecialOfferScreen(),
  ProfileScreen.route(): (context) => const ProfileScreen(),
  // ProductDetail.route(): (context) => const ProductDetail(),
  TestScreen.route(): (context) => const TestScreen(),
};
