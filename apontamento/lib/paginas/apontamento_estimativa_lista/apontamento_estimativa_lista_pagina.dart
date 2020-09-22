import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/repositorios/preferencia_repository.dart';
import 'package:apontamento/comun/repositorios/repositorio_estimativa.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_bloc.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_conteudo.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_eventos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApontamentoEstimativaListaPagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApontamentoEstimativaListaBloc(
        repositorioEstimativa: RepositorioEstimativa(db: Db()),
        preferenciaRepository: PreferenciaRepository(db: Db()),
      )..add(IniciarListaEstimativas()),
      child: Scaffold(
        body: ApontamentoEstimativaListaConteudo(),
      ),
    );
  }
}
