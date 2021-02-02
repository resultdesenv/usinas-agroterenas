import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/repositorios/apont_broca_consulta_repository.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_bloc.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApontamentoBrocaListaPage extends StatefulWidget {
  @override
  _ApontamentoBrocaListaPageState createState() =>
      _ApontamentoBrocaListaPageState();
}

class _ApontamentoBrocaListaPageState extends State<ApontamentoBrocaListaPage> {
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
    return BlocProvider<ApontamentoBrocaListaBloc>(
      create: (_) => ApontamentoBrocaListaBloc(
        repositorioBroca: ApontBrocaConsultaRepository(db: Db()),
        preferenciaRepository: PreferenciaRepository(db: Db()),
      ),
      child: Scaffold(
        body: ApontamentoBrocaListaContent(scaffoldKey: scaffoldKey),
      ),
    );
  }
}
