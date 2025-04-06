



import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {

  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();

  void update() => notifyListeners();

}