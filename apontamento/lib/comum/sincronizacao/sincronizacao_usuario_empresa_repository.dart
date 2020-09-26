import 'package:apontamento/comum/modelo/usuario_empresa_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:apontamento/comum/db/db.dart';
import 'package:apontamento/comum/modelo/usuario_model.dart';
import 'package:apontamento/comum/sincronizacao/sincronizacao_base.dart';

import 'sincronizacao_historico_repository.dart';

class SincronizacaoUsuarioEmpresaRepository
    implements SincronizacaoBase<Usuario> {
  Dio dio;
  final Db db;
  final SincronizacaoHistoricoRepository sincronizacaoHistoricoRepository;

  SincronizacaoUsuarioEmpresaRepository(
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
    final usuarioEmpresa = await buscar(token);
    final dataFinal = DateTime.now();
    await salvar(
        usuarioEmpresa,
        Duration(
            milliseconds: dataFinal.millisecondsSinceEpoch -
                dataInicial.millisecondsSinceEpoch));
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

  Future<void> salvar(
      List<UsuarioEmpresaModel> usuarioEmpresas, Duration duracao) async {
    final dbInstancia = await db.get();
    for (final usuarioEmpresa in usuarioEmpresas) {
      await dbInstancia.insert('usuario_emp', usuarioEmpresa.toJson());
    }
    await sincronizacaoHistoricoRepository.salvarDataAtualizacao(
        'usuario_emp', duracao, usuarioEmpresas.length);
  }
}
