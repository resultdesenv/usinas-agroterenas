import 'package:apontamento/comun/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/modelo/usuario_model.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_base.dart';

class SincronizacaoUsuarioRepository implements SincronizacaoBase<Usuario> {
  final Db db;
  final Dio dio;
  final SincronizacaoHistoricoRepository sincronizacaoHistoricoRepository;

  SincronizacaoUsuarioRepository(
      {@required this.db,
      @required this.dio,
      @required this.sincronizacaoHistoricoRepository});

  Future<void> index(
    String token, {
    String cdInstManfro,
    String cdSafra,
  }) async {
    print('index usuario');
    await limpar();
    final usuarios = await buscar(token);
    await salvar(usuarios);
  }

  Future<void> limpar() async {
    final dbInstancia = await db.get();
    await dbInstancia.delete('usuario');
  }

  Future<List<Usuario>> buscar(String token) async {
    final res = await dio.get('/agt-api-pims/api/usuario/lista/all',
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }));
    final List listaUsuariosJson = res.data;
    return listaUsuariosJson
        .map((usuarioJson) => Usuario.fromJson(usuarioJson))
        .toList();
  }

  Future<void> salvar(List<Usuario> usuarios) async {
    final dbInstancia = await db.get();
    for (final usuario in usuarios) {
      await dbInstancia.insert('usuario', usuario.toJson());
    }
    await sincronizacaoHistoricoRepository.salvarDataAtualizacao('usuario');
  }
}
