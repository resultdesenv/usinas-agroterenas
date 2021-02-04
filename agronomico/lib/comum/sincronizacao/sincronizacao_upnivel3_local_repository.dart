import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/modelo/usuario_model.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_base.dart';
import 'package:sqflite/sql.dart';

class SincronizacaoUpNivel3LocalRepository
    implements SincronizacaoBase<Usuario> {
  Dio dio;
  final Db db;
  final SincronizacaoHistoricoRepository sincronizacaoHistoricoRepository;

  SincronizacaoUpNivel3LocalRepository({
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
    final upnivel3 = await buscar(token, cdInstManfro, cdSafra, nivel2);
    await salvar(upnivel3, dataInicial);
  }

  Future<void> limpar() async {
    final dbInstancia = await db.get();
    await dbInstancia.delete('upnivel3');
  }

  Future<List<UpNivel3Model>> buscar(
    String token,
    String cdInstManfro,
    String cdSafra,
    String nivel2,
  ) async {
    final url = nivel2 != null && nivel2.isNotEmpty
        ? '/agt-api-pims/api/locais/instancia/NAPAR/zona/$nivel2'
        : '/agt-api-pims/api/locais/instancia/NAPAR';
    print(url);
    print('token $token');
    final res = await dio.get(
      url,
      options: Options(headers: {
        'authorization': 'Bearer $token',
      }),
    );
    final List listaUpNivelJson = res.data;
    print('NIVEL2 $nivel2');
    print('Qtd Registros ${listaUpNivelJson.length}');
    return listaUpNivelJson
        .map((upnivelJson) => UpNivel3Model.fromJson(upnivelJson))
        .toList();
  }

  Future<void> salvar(
    List<UpNivel3Model> upnivels,
    DateTime dataInicial,
  ) async {
    final dbInstancia = await db.get();
    final batch = dbInstancia.batch();

    for (final upnivel in upnivels) {
      batch.insert(
        'upnivel3',
        upnivel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);

    await sincronizacaoHistoricoRepository.salvarDataAtualizacao(
      'upnivel3',
      Duration(
          milliseconds: DateTime.now().millisecondsSinceEpoch -
              dataInicial.millisecondsSinceEpoch),
      upnivels.length,
    );
  }
}
