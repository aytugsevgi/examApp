import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicWidth(double value) => MediaQuery.of(this).size.width * value;
  double dynamicHeight(double value) => MediaQuery.of(this).size.height * value;
  ThemeData get themeData => Theme.of(this);
}

extension IntegerExtension on int {
  String get force2digitToString =>
      this < 10 ? "0" + this.toString() : this.toString();
}
