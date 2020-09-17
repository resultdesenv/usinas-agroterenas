import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/repositorios/epnivel3_consulta_repository.dart';
import 'package:apontamento/comun/repositorios/preferencia_repository.dart';
import 'package:apontamento/comun/repositorios/repositorio_estimativa.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_bloc.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_content.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_event.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpNivel3Page extends StatelessWidget {
  final bool selecaoMultipla;

  UpNivel3Page({this.selecaoMultipla = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpNivel3Bloc(
        upNivel3ConsultaRepository: UpNivel3ConsultaRepository(db: Db()),
        preferenciaRepository: PreferenciaRepository(db: Db()),
        estimativaRepository: RepositorioEstimativa(db: Db(), dio: Dio()),
      )..add(IniciarListaUpNivel3()),
      child: Scaffold(
        body: UpNivel3Content(selecaoMultipla: selecaoMultipla),
      ),
    );
  }
}
