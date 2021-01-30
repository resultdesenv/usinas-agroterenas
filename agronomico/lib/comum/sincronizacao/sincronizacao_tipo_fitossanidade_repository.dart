import 'package:agronomico/comum/modelo/tipo_fitossanidade_model.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/modelo/usuario_model.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_base.dart';
import 'package:sqflite/sql.dart';

class SincronizacaoTipoFitossanidadeRepository
    implements SincronizacaoBase<Usuario> {
  Dio dio;
  final Db db;
  final SincronizacaoHistoricoRepository sincronizacaoHistoricoRepository;

  SincronizacaoTipoFitossanidadeRepository({
    @required this.db,
    @required this.dio,
    @required this.sincronizacaoHistoricoRepository,
  });

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
    await dbInstancia.delete('tipo_fitossanidade');
  }

  Future<List<TipoFitossanidadeModel>> buscar(String token) async {
    final res = await dio.get(
      '/agt-api-pims/api/fitossanidade/tipos-brocas',
      options: Options(headers: {
        'authorization': 'Bearer $token',
      }),
    );
    final List listaTipoFitossanidadesJson = res.data;
    return listaTipoFitossanidadesJson
        .map((fitossanidadeJson) =>
            TipoFitossanidadeModel.fromJson(fitossanidadeJson))
        .toList();
  }

  Future<void> salvar(List<TipoFitossanidadeModel> tipoFitossanidades,
      DateTime dataInicial) async {
    final dbInstancia = await db.get();
    for (final tipoFitossanidade in tipoFitossanidades) {
      await dbInstancia.insert(
        'tipo_fitossanidade',
        tipoFitossanidade.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await sincronizacaoHistoricoRepository.salvarDataAtualizacao(
      'tipo_fitossanidade',
      Duration(
        milliseconds: DateTime.now().millisecondsSinceEpoch -
            dataInicial.millisecondsSinceEpoch,
      ),
      tipoFitossanidades.length,
    );
  }
}
