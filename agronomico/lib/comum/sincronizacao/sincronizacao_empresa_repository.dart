import 'package:agronomico/comum/modelo/empresa_model.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/modelo/usuario_model.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_base.dart';

class SincronizacaoEmpresaRepository implements SincronizacaoBase<Usuario> {
  Dio dio;
  final Db db;
  final SincronizacaoHistoricoRepository sincronizacaoHistoricoRepository;

  SincronizacaoEmpresaRepository(
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
    String nivel2,
  }) async {
    final dataInicial = DateTime.now();
    await limpar();
    final usuarios = await buscar(token);
    await salvar(usuarios, dataInicial);
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

  Future<void> salvar(List<EmpresaModel> empresas, DateTime dataInicial) async {
    final dbInstancia = await db.get();
    for (final empresa in empresas) {
      await dbInstancia.insert('empresa', empresa.toJson());
    }
    await sincronizacaoHistoricoRepository.salvarDataAtualizacao(
        'empresa',
        Duration(
            milliseconds: DateTime.now().millisecondsSinceEpoch -
                dataInicial.millisecondsSinceEpoch),
        empresas.length);
  }
}
