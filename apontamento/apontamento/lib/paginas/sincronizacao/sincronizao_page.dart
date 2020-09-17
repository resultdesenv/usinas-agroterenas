import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comun/componentes/drawer_menu.dart';
import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/modelo/sincronizacao_item_atualizacao_model.dart';
import 'package:apontamento/comun/repositorios/safra_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_autenticacao.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_empresa_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_safra_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_upnivel3_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_usuario_empresa_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_usuario_repository.dart';
import 'package:apontamento/paginas/sincronizacao/sincronizao_bloc.dart';
import 'package:apontamento/paginas/sincronizacao/sincronizao_content.dart';
import 'package:apontamento/paginas/sincronizacao/sincronizao_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SincronizacaoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dio = BaseInherited.of(context).dio;
    return Scaffold(
        appBar: AppBar(title: Text('Sincronização')),
        drawer: DrawerMenu(),
        body: BlocProvider<SincronizacaoBloc>(
            create: (context) => SincronizacaoBloc(
                safraRepository: SafraRepository(db: Db()),
                sincronizacaoHistoricoRepository:
                    SincronizacaoHistoricoRepository(db: Db()),
                sincronizacaoAutenticacao: SincronizacaoAutenticacao(dio: dio))
              ..add(BuscarItensSincronizacao(itensSincronizacao: [
                HistoricoItemAtualizacaoModel(
                    nome: 'Usuario',
                    tabela: 'usuario',
                    repository: SincronizacaoUsuarioRepository(
                        db: Db(),
                        sincronizacaoHistoricoRepository:
                            SincronizacaoHistoricoRepository(db: Db()),
                        dio: dio)),
                HistoricoItemAtualizacaoModel(
                    nome: 'Empresa',
                    tabela: 'empresa',
                    repository: SincronizacaoEmpresaRepository(
                        db: Db(),
                        sincronizacaoHistoricoRepository:
                            SincronizacaoHistoricoRepository(db: Db()),
                        dio: dio)),
                HistoricoItemAtualizacaoModel(
                    nome: 'Usuario x Empresa',
                    tabela: 'usuario_emp',
                    repository: SincronizacaoUsuarioEmpresaRepository(
                        db: Db(),
                        sincronizacaoHistoricoRepository:
                            SincronizacaoHistoricoRepository(db: Db()),
                        dio: dio)),
                HistoricoItemAtualizacaoModel(
                    nome: 'Safra',
                    tabela: 'safra',
                    repository: SincronizacaoSafraRepository(
                        db: Db(),
                        sincronizacaoHistoricoRepository:
                            SincronizacaoHistoricoRepository(db: Db()),
                        dio: dio)),
                HistoricoItemAtualizacaoModel(
                    upnivel3: true,
                    nome: 'Área Nivel3 por Safra',
                    tabela: 'upnivel3',
                    repository: SincronizacaoUpNivel3Repository(
                        db: Db(),
                        sincronizacaoHistoricoRepository:
                            SincronizacaoHistoricoRepository(db: Db()),
                        dio: dio))
              ])),
            child: SincronizacaoContent()));
  }
}
