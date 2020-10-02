import 'package:apontamento/tema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'base_bloc.dart';
import 'base_inherited.dart';
import 'base_state.dart';

class BaseBuilder extends StatelessWidget {
  final String title;
  final Widget home;

  BaseBuilder({@required this.title, @required this.home});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseBloc, BaseState>(builder: (context, state) {
      if (!state.pronto) return Center(child: CircularProgressIndicator());
      return BaseInherited(
          url: state.url,
          empresaAutenticada: state.empresaAutenticada,
          usuarioAutenticada: state.usuarioAutenticada,
          child: MaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              supportedLocales: [
                const Locale('pt', 'BR')
              ],
              title: title,
              home: home,
              theme: tema,
              debugShowCheckedModeBanner: false));
    });
  }
}
