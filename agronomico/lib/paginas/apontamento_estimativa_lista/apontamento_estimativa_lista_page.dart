import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:agronomico/comum/repositorios/repositorio_estimativa.dart';
import 'package:agronomico/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_bloc.dart';
import 'package:agronomico/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_content.dart';
import 'package:agronomico/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApontamentoEstimativaListaPage extends StatefulWidget {
  @override
  _ApontamentoEstimativaListaPageState createState() =>
      _ApontamentoEstimativaListaPageState();
}

class _ApontamentoEstimativaListaPageState
    extends State<ApontamentoEstimativaListaPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 380), () {
      if (scaffoldKey.currentState != null)
        scaffoldKey.currentState.openEndDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApontamentoEstimativaListaBloc(
        repositorioEstimativa: RepositorioEstimativa(db: Db()),
        preferenciaRepository: PreferenciaRepository(db: Db()),
      )..add(IniciarListaEstimativas()),
      child: Scaffold(
        body: ApontamentoEstimativaListaContent(scaffoldKey: scaffoldKey),
      ),
    );
  }
}
