import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Responsive {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  // Call this method in initState or build method
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  // Get Platform Type
  static bool isAndroid() => Platform.isAndroid;
  static bool isIOS() => Platform.isIOS;
  static bool isWeb() => kIsWeb;
  static bool isWindows() => Platform.isWindows;
  static bool isMacOS() => Platform.isMacOS;
  static bool isLinux() => Platform.isLinux;

  // Responsive Breakpoints
  static bool isMobile() => screenWidth < 600;
  static bool isTablet() => screenWidth >= 600 && screenWidth < 1024;
  static bool isDesktop() => screenWidth >= 1024;

  // Get Width & Height
  static double getWidth(double percentage) => screenWidth * (percentage / 100);
  static double getHeight(double percentage) => screenHeight * (percentage / 100);
}
