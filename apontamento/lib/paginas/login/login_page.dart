import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/paginas/login/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        key: _scaffoldKey,
        body: BlocProvider(
            create: (context) =>
                LoginBloc(loginRepository: LoginRepository(db: Db()))
                  ..add(Started()),
            child: LoginContent()));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
