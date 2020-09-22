import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/modelo/sincronizacao_out_model.dart';
import 'package:apontamento/comun/repositorios/preferencia_repository.dart';
import 'package:apontamento/comun/sincronizacao/estimativa_out_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_autenticacao.dart';
import 'package:apontamento/paginas/sincronizacao_out/sincronizacao_out_bloc.dart';
import 'package:apontamento/paginas/sincronizacao_out/sincronizacao_out_content.dart';
import 'package:apontamento/paginas/sincronizacao_out/sincronizacao_out_event.dart';
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
        ])),
      child: Scaffold(body: SincronizacaoOutContent()),
    );
  }
}
