import 'package:apontamento/comun/modelo/empresa_model.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/modelo/usuario_model.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_base.dart';

class SincronizacaoEmpresaRepository implements SincronizacaoBase<Usuario> {
  final Db db;
  final Dio dio;
  final SincronizacaoHistoricoRepository sincronizacaoHistoricoRepository;

  SincronizacaoEmpresaRepository(
      {@required this.db,
      @required this.dio,
      @required this.sincronizacaoHistoricoRepository});

  Future<void> index(
    String token, {
    String cdInstManfro,
    String cdSafra,
  }) async {
    await limpar();
    final usuarios = await buscar(token);
    await salvar(usuarios);
  }

  Future<void> limpar() async {
    final dbInstancia = await db.get();
    await dbInstancia.delete('empresa');
  }

  Future<List<EmpresaModel>> buscar(String token) async {
    final res = await dio.get('/agt-api-pims/api/empresas/lista/all',
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }));
    final List listaUsuariosJson = res.data;
    return listaUsuariosJson
        .map((usuarioJson) => EmpresaModel.fromJson(usuarioJson))
        .toList();
  }

  Future<void> salvar(List<EmpresaModel> empresas) async {
    final dbInstancia = await db.get();
    for (final empresa in empresas) {
      await dbInstancia.insert('empresa', empresa.toJson());
    }
    await sincronizacaoHistoricoRepository.salvarDataAtualizacao('empresa');
  }
}
