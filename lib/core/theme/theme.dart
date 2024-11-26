import 'package:flutter/material.dart';

class MyTheme {
  final appTheme = const AppBarTheme(
    centerTitle: true,
    color: Colors.purple,
    actionsIconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  );
}
