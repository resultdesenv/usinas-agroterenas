import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/modelo/usuario_model.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_base.dart';

class SincronizacaoUpNivel3Repository implements SincronizacaoBase<Usuario> {
  Dio dio;
  final Db db;
  final SincronizacaoHistoricoRepository sincronizacaoHistoricoRepository;

  SincronizacaoUpNivel3Repository(
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
    final upnivel3 = await buscar(token, cdInstManfro, cdSafra);
    await salvar(upnivel3, dataInicial);
  }

  Future<void> limpar() async {
    final dbInstancia = await db.get();
    await dbInstancia.delete('upnivel3');
  }

  Future<List<UpNivel3Model>> buscar(
      String token, String cdInstManfro, String cdSafra) async {
    print(
        '/agt-api-pims/api/estimativa/consulta?instancia=$cdInstManfro&cdSafra=$cdSafra');
    final res = await dio.get(
        '/agt-api-pims/api/estimativa/consulta?instancia=$cdInstManfro&cdSafra=$cdSafra',
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }));
    final List listaUpNivelJson = res.data;
    print('SAFRA $cdSafra');
    print('Qtd Registros ${listaUpNivelJson.length}');
    return listaUpNivelJson
        .map((upnivelJson) => UpNivel3Model.fromJson(upnivelJson))
        .toList();
  }

  Future<void> salvar(List<UpNivel3Model> upnivels, DateTime dataInicial) async {
    final dbInstancia = await db.get();
    for (final upnivel in upnivels) {
      await dbInstancia.insert('upnivel3', upnivel.toJson());
    }
    await sincronizacaoHistoricoRepository.salvarDataAtualizacao(
        'upnivel3', Duration(
        milliseconds: DateTime.now().millisecondsSinceEpoch -
            dataInicial.millisecondsSinceEpoch), upnivels.length);
  }
}
