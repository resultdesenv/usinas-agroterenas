import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/modelo/estimativa_modelo.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:agronomico/comum/repositorios/repositorio_estimativa.dart';
import 'package:agronomico/comum/repositorios/sequencia_repository.dart';
import 'package:agronomico/comum/repositorios/upnivel3_consulta_repository.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:agronomico/paginas/apontamento_estimativa_form/apontamento_estimativa_bloc.dart';
import 'package:agronomico/paginas/apontamento_estimativa_form/apontamento_estimativa_content.dart';
import 'package:agronomico/paginas/apontamento_estimativa_form/apontamento_estimativa_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApontamentoEstimativaPage extends StatelessWidget {
  final List<EstimativaModelo> apontamentos;
  final bool criacao;
  final String mensagemInicial;

  ApontamentoEstimativaPage({
    @required this.apontamentos,
    this.criacao = false,
    this.mensagemInicial,
  });

  @override
  Widget build(BuildContext context) {
    final dio = BaseInherited.of(context).dio;

    return BlocProvider(
      create: (context) => ApontamentoEstimativaBloc(
        criacao: criacao,
        repositorioEstimativa: RepositorioEstimativa(db: Db()),
        upNivel3ConsultaRepository: UpNivel3ConsultaRepository(db: Db()),
        sequenciaRepository: SincronizacaoSequenciaRepository(
          db: Db(),
          dio: dio,
          preferenciaRepository: PreferenciaRepository(db: Db()),
          sincronizacaoHistoricoRepository:
              SincronizacaoHistoricoRepository(db: Db()),
        ),
      )..add(AdicionarApontamento(
          apontamentos: apontamentos,
          mensagemInicial: mensagemInicial,
        )),
      child: Scaffold(
        body: ApontamentoEstimativaContent(),
      ),
    );
  }
}
