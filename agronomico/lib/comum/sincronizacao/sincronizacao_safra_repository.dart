import 'package:agronomico/comum/modelo/safra_model.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/modelo/usuario_model.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_base.dart';

class SincronizacaoSafraRepository implements SincronizacaoBase<Usuario> {
  Dio dio;
  final Db db;
  final SincronizacaoHistoricoRepository sincronizacaoHistoricoRepository;

  SincronizacaoSafraRepository(
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
    final usuarios = await buscar(token, cdInstManfro);
    await salvar(usuarios, dataInicial);
  }

  Future<void> limpar() async {
    final dbInstancia = await db.get();
    await dbInstancia.delete('safra');
  }

  Future<List<SafraModel>> buscar(String token, String cdInstManfro) async {
    final res = await dio.get('/agt-api-pims/api/safra/instancia/$cdInstManfro',
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }));
    final List listaSafraJson = res.data;

    return listaSafraJson
        .map((safraJson) => SafraModel.fromJson(safraJson))
        .toList();
  }

  Future<void> salvar(List<SafraModel> safras, DateTime dataInicial) async {
    final dbInstancia = await db.get();
    for (final safra in safras) {
      await dbInstancia.insert('safra', safra.toJson());
    }
    await sincronizacaoHistoricoRepository.salvarDataAtualizacao(
        'safra',
        Duration(
            milliseconds: DateTime.now().millisecondsSinceEpoch -
                dataInicial.millisecondsSinceEpoch),
        safras.length);
  }
}
