import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/modelo/sincronizacao_out_model.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:agronomico/comum/sincronizacao/broca_out_repository.dart';
import 'package:agronomico/comum/sincronizacao/estimativa_out_repository.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_autenticacao.dart';
import 'package:agronomico/paginas/sincronizacao_out/sincronizacao_out_bloc.dart';
import 'package:agronomico/paginas/sincronizacao_out/sincronizacao_out_content.dart';
import 'package:agronomico/paginas/sincronizacao_out/sincronizacao_out_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SincronizacaoOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final instancia = BaseInherited.of(context).empresaAutenticada.cdInstManfro;
    final dio = BaseInherited.of(context).dio;

    return BlocProvider(
      create: (context) => SincronizacaoOutBloc(
          sincronizacaoAutenticacao: SincronizacaoAutenticacao(dio: dio))
        ..add(IniciaEstadoSincronizacaoOut(sincronizacaoItens: [
          SincronizacaoOutModel(
            titulo: 'Apontamento Estimativa',
            repositorio: EstimativaOutRepository(
              db: Db(),
              dio: dio,
              preferenciaRepository: PreferenciaRepository(db: Db()),
            ),
            instancia: instancia,
          ),
          SincronizacaoOutModel(
            titulo: 'Apontamento Broca',
            repositorio: BrocaOutRepository(
              db: Db(),
              dio: dio,
              preferenciaRepository: PreferenciaRepository(db: Db()),
            ),
            instancia: instancia,
          ),
        ])),
      child: Scaffold(body: SincronizacaoOutContent()),
    );
  }
}
