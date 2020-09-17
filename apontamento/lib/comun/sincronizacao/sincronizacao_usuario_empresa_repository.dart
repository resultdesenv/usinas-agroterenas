import 'package:apontamento/comun/modelo/usuario_empresa_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/modelo/usuario_model.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_base.dart';

import 'sincronizacao_historico_repository.dart';

class SincronizacaoUsuarioEmpresaRepository
    implements SincronizacaoBase<Usuario> {
  final Db db;
  final Dio dio;
  final SincronizacaoHistoricoRepository sincronizacaoHistoricoRepository;

  SincronizacaoUsuarioEmpresaRepository(
      {@required this.db,
      @required this.dio,
      @required this.sincronizacaoHistoricoRepository});

  Future<void> index(
    String token, {
    String cdInstManfro,
    String cdSafra,
  }) async {
    await limpar();
    final usuarioEmpresa = await buscar(token);
    await salvar(usuarioEmpresa);
  }

  Future<void> limpar() async {
    final dbInstancia = await db.get();
    await dbInstancia.delete('usuario_emp');
  }

  Future<List<UsuarioEmpresaModel>> buscar(String token) async {
    final res =
        await dio.get('/agt-api-pims/api/usuario/lista/usuario/instancia/all',
            options: Options(headers: {
              'authorization': 'Bearer $token',
            }));
    final List listaUsuariosEmpresaJson = res.data;
    return listaUsuariosEmpresaJson
        .map((usuarioJson) => UsuarioEmpresaModel.fromJson(usuarioJson))
        .toList();
  }

  Future<void> salvar(List<UsuarioEmpresaModel> usuarioEmpresas) async {
    final dbInstancia = await db.get();
    for (final usuarioEmpresa in usuarioEmpresas) {
      await dbInstancia.insert('usuario_emp', usuarioEmpresa.toJson());
    }
    await sincronizacaoHistoricoRepository.salvarDataAtualizacao('usuario_emp');
  }
}
