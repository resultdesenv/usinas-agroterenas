import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final corPrimaria = Color(0xFF03A9F4);
final corSecundaria = Color(0xFF6200EE);

final tema = ThemeData(
  primaryColor: corPrimaria,
  accentColor: corSecundaria,
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: corPrimaria,
    elevation: 0,
    textTheme:
        TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 18)),
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white),
    centerTitle: true,
  ),
  inputDecorationTheme: temaInput,
  cursorColor: corSecundaria,
);

final temaInput = InputDecorationTheme(
  fillColor: corPrimaria,
  labelStyle: TextStyle(color: corPrimaria),
);
