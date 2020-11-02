import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class SincronizacaoOutInterface {
  final Db db;
  final Dio dio;
  final PreferenciaRepository preferenciaRepository;

  SincronizacaoOutInterface({
    @required this.db,
    @required this.dio,
    @required this.preferenciaRepository,
  });

  Future<List<Map<String, dynamic>>> buscarItens();
  Future<void> sincronizar({@required String token});
  Future<void> atualizarStatus({@required List<Map<String, dynamic>> itens});
  Future<Map<String, dynamic>> buscaInfo({@required String instancia});
  Future<void> salvaInfo({@required Map<String, dynamic> info});
}

abstract class SincronizacaoOutRepository implements SincronizacaoOutInterface {
}
