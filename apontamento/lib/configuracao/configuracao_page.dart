import 'package:apontamento/base/base_bloc.dart';
import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/repositorios/preferencia_repository.dart';
import 'package:apontamento/comun/repositorios/sequencia_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_autenticacao.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_completa_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_empresa_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_usuario_empresa_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_usuario_repository.dart';
import 'package:apontamento/configuracao/configuracaoRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_moment/simple_moment.dart';

import 'configuracao.dart';

class ConfiguracaoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final baseBloc = BlocProvider.of<BaseBloc>(context);
    final dio = BaseInherited.of(context).dio;
    Moment.setLocaleGlobally(new LocalePtBr());

    return Scaffold(
        appBar: AppBar(title: Text('Configuração')),
        body: BlocProvider<ConfiguracaoBloc>(
          create: (context) => ConfiguracaoBloc(
              preferenciaRepository: PreferenciaRepository(db: Db()),
              sincronizacaoSequenciaRepository:
                  SincronizacaoSequenciaRepository(
                      db: Db(),
                      dio: dio,
                      preferenciaRepository: PreferenciaRepository(db: Db()),
                      sincronizacaoHistoricoRepository:
                          SincronizacaoHistoricoRepository(db: Db())),
              baseBloc: baseBloc,
              configuracaoRepository: ConfiguracaoRepository(),
              sincronizacaoAutenticacao: SincronizacaoAutenticacao(dio: dio),
              sincronizacaoCompletaRepository:
                  SincronizacaoCompletaRepository(list: [
                SincronizacaoUsuarioRepository(
                    dio: dio,
                    db: Db(),
                    sincronizacaoHistoricoRepository:
                        SincronizacaoHistoricoRepository(db: Db())),
                SincronizacaoEmpresaRepository(
                    dio: dio,
                    db: Db(),
                    sincronizacaoHistoricoRepository:
                        SincronizacaoHistoricoRepository(db: Db())),
                SincronizacaoUsuarioEmpresaRepository(
                    dio: dio,
                    db: Db(),
                    sincronizacaoHistoricoRepository:
                        SincronizacaoHistoricoRepository(db: Db())),
                SincronizacaoSequenciaRepository(
                    dio: dio,
                    preferenciaRepository: PreferenciaRepository(db: Db()),
                    db: Db(),
                    sincronizacaoHistoricoRepository:
                        SincronizacaoHistoricoRepository(db: Db())),
              ]))
            ..add(Iniciar()),
          child: ConfiguracaoContent(),
        ));
  }
}
