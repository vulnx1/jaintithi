import 'package:flutter/material.dart';

class Responsive {
  /// Returns a value based on screen width
  static double value(BuildContext context, double mobile, double tablet) {
    final width = MediaQuery.of(context).size.width;
    return width < 600 ? mobile : tablet;
  }

  /// Returns true if screen is considered mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  /// Returns true if screen is considered tablet or larger
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }
}
