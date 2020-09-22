import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/repositorios/epnivel3_consulta_repository.dart';
import 'package:apontamento/comun/repositorios/preferencia_repository.dart';
import 'package:apontamento/comun/repositorios/repositorio_estimativa.dart';
import 'package:apontamento/comun/repositorios/sequencia_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_bloc.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_content.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_event.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpNivel3Page extends StatefulWidget {
  final bool selecaoMultipla;

  UpNivel3Page({this.selecaoMultipla = false});

  @override
  _UpNivel3PageState createState() => _UpNivel3PageState();
}

class _UpNivel3PageState extends State<UpNivel3Page> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool initialized = false;
  @override
  void initState() {
    super.initState();
    // TODO: Arrumar isso para funcionar sem o future;
    Future.delayed(Duration(milliseconds: 380), () {
      if (scaffoldKey.currentState != null)
        scaffoldKey.currentState.openEndDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dio = BaseInherited.of(context).dio;

    return BlocProvider(
      create: (context) => UpNivel3Bloc(
        sequenciaRepository: SincronizacaoSequenciaRepository(
          db: Db(),
          dio: dio,
          preferenciaRepository: PreferenciaRepository(db: Db()),
          sincronizacaoHistoricoRepository:
              SincronizacaoHistoricoRepository(db: Db()),
        ),
        upNivel3ConsultaRepository: UpNivel3ConsultaRepository(db: Db()),
        preferenciaRepository: PreferenciaRepository(db: Db()),
        estimativaRepository: RepositorioEstimativa(db: Db()),
      )..add(IniciarListaUpNivel3()),
      child: Scaffold(
        body: UpNivel3Content(
          selecaoMultipla: widget.selecaoMultipla,
          scaffoldKey: scaffoldKey,
        ),
      ),
    );
  }
}
