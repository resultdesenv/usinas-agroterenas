import 'package:apontamento/comum/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:apontamento/comum/db/db.dart';
import 'package:apontamento/comum/modelo/usuario_model.dart';
import 'package:apontamento/comum/sincronizacao/sincronizacao_base.dart';

class SincronizacaoUsuarioRepository implements SincronizacaoBase<Usuario> {
  Dio dio;
  final Db db;
  final SincronizacaoHistoricoRepository sincronizacaoHistoricoRepository;

  SincronizacaoUsuarioRepository(
      {@required this.db,
      @required this.dio,
      @required this.sincronizacaoHistoricoRepository});

  updateDio(Dio dio) {
    this.dio = dio;
  }

  Future<void> index(
    String token, {
    String cdInstManfro,
    String cdSafra,
  }) async {
    final dataInicial = DateTime.now();
    await limpar();
    final usuarios = await buscar(token);
    final dataFinal = DateTime.now();
    await salvar(
        usuarios,
        Duration(
            milliseconds: dataFinal.millisecondsSinceEpoch -
                dataInicial.millisecondsSinceEpoch));
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

  Future<void> salvar(List<Usuario> usuarios, Duration duracao) async {
    final dbInstancia = await db.get();
    for (final usuario in usuarios) {
      await dbInstancia.insert('usuario', usuario.toJson());
    }
    await sincronizacaoHistoricoRepository.salvarDataAtualizacao(
        'usuario', duracao, usuarios.length);
  }
}
