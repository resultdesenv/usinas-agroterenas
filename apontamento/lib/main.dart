import 'package:apontamento/paginas/login/login.dart';
import 'package:flutter/material.dart';
import 'base/base_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseProvider(
      title: 'App Usina',
      home: LoginPage(),
    );
  }
}
