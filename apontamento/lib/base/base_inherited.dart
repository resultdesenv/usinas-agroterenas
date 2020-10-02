import 'package:apontamento/comum/modelo/empresa_model.dart';
import 'package:apontamento/comum/modelo/usuario_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseInherited extends InheritedWidget {
  final Dio dio;
  final EmpresaModel empresaAutenticada;
  final Usuario usuarioAutenticada;

  BaseInherited({
    Key key,
    @required String url,
    @required Widget child,
    this.empresaAutenticada,
    this.usuarioAutenticada,
  })  : dio = Dio(BaseOptions(baseUrl: url)),
        super(key: key, child: child);

  static BaseInherited of(BuildContext context) {
    // ignore: deprecated_member_use
    return context.inheritFromWidgetOfExactType(BaseInherited) as BaseInherited;
  }

  @override
  bool updateShouldNotify(BaseInherited old) => true;
}
