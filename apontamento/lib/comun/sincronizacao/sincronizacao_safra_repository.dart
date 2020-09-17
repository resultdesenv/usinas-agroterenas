import 'package:apontamento/comun/modelo/safra_model.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/modelo/usuario_model.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_base.dart';

class SincronizacaoSafraRepository implements SincronizacaoBase<Usuario> {
  final Db db;
  final Dio dio;
  final SincronizacaoHistoricoRepository sincronizacaoHistoricoRepository;

  SincronizacaoSafraRepository(
      {@required this.db,
      @required this.dio,
      @required this.sincronizacaoHistoricoRepository});

  Future<void> index(
    String token, {
    String cdInstManfro,
    String cdSafra,
  }) async {
    await limpar();
    final usuarios = await buscar(token, cdInstManfro);
    await salvar(usuarios);
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

  Future<void> salvar(List<SafraModel> safras) async {
    final dbInstancia = await db.get();
    for (final safra in safras) {
      await dbInstancia.insert('safra', safra.toJson());
    }
    await sincronizacaoHistoricoRepository.salvarDataAtualizacao('safra');
  }
}
