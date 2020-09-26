import 'package:apontamento/comum/db/db.dart';
import 'package:apontamento/comum/repositorios/preferencia_repository.dart';
import 'package:apontamento/comum/repositorios/repositorio_estimativa.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_bloc.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_content.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApontamentoEstimativaListaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApontamentoEstimativaListaBloc(
        repositorioEstimativa: RepositorioEstimativa(db: Db()),
        preferenciaRepository: PreferenciaRepository(db: Db()),
      )..add(IniciarListaEstimativas()),
      child: Scaffold(
        body: ApontamentoEstimativaListaContent(),
      ),
    );
  }
}
