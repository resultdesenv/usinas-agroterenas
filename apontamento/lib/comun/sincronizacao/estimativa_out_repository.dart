import 'dart:convert';

import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/repositorios/preferencia_repository.dart';
import 'package:apontamento/comun/repositorios/repositorio_estimativa.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_out_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_moment/simple_moment.dart';

class EstimativaOutRepository extends SincronizacaoOutRepository {
  final Db db;
  final Dio dio;
  final PreferenciaRepository preferenciaRepository;

  EstimativaOutRepository({
    @required this.db,
    @required this.dio,
    @required this.preferenciaRepository,
  });

  Future<List<Map<String, dynamic>>> buscarItens() async {
    final banco = await db.get();
    final res = await banco.query(
      'apont_estimativa',
      columns: colunasEstimativa,
      where: 'status in (?, ?)',
      whereArgs: ['P', 'E'],
    );

    return res;
  }

  Future<void> sincronizar({@required String token}) async {
    final Map<String, dynamic> infoSinc = await preferenciaRepository
        .get(idPreferencia: 'sinc-out-estimativa')
        .then((valor) => valor != null ? json.decode(valor) : {});

    List<Map<String, dynamic>> itens = await buscarItens();
    final Map<String, dynamic> info = Map.from(infoSinc);

    try {
      final inicioSincronizacao = DateTime.now();

      await dio.post(
        '/agt-api-pims/api/estimativa/insert',
        data: itens,
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }),
      );

      final diferenca = DateTime.now().difference(inicioSincronizacao);
      final duracaoSincronizacao = diferenca.inMinutes > 0
          ? '${diferenca.inMinutes} minutos'
          : '${diferenca.inSeconds} segundos';

      info['duracaoSincronizacao'] = duracaoSincronizacao;
      info['dataUltimaSincronizacao'] = Moment.now().format('yyyy-MM-dd');
      info['quantidadeSincronizada'] = itens.length;

      await salvaInfo(info: info);

      itens = itens.map((e) => {...e, 'status': 'I'}).toList();
      await atualizarStatus(itens: itens);
    } catch (e) {
      print(e);
      itens = itens.map((e) => {...e, 'status': 'E'}).toList();
      await atualizarStatus(itens: itens);
      throw e;
    }
  }

  Future<void> atualizarStatus({
    @required List<Map<String, dynamic>> itens,
  }) async {
    final banco = await db.get();

    for (var item in itens) {
      await banco.update(
        'apont_estimativa',
        item,
        where:
            'dispositivo = ? AND instancia = ? AND noBoletim = ? AND noSeq = ?',
        whereArgs: [
          item['dispositivo'],
          item['instancia'],
          item['noBoletim'],
          item['noSeq'],
        ],
      );
    }
  }

  Future<Map<String, dynamic>> buscaInfo({@required String instancia}) async {
    final banco = await db.get();

    final int naoSincronizadas = await banco
        .rawQuery(
          'SELECT COUNT(*) as naoSincronizadas '
          'FROM apont_estimativa WHERE instancia = \'$instancia\' '
          'AND status in (\'P\',\'E\')',
        )
        .then((valor) => valor[0]['naoSincronizadas']);

    final bool naoSincronizadasOutras = await banco
        .rawQuery(
          'SELECT COUNT(*) as naoSincronizadasOutras '
          'FROM apont_estimativa WHERE instancia != \'$instancia\' '
          'AND status in (\'P\',\'E\') LIMIT 1',
        )
        .then((valor) => valor[0]['naoSincronizadasOutras'] > 0);

    final Map<String, dynamic> infoSinc = await preferenciaRepository
        .get(idPreferencia: 'sinc-out-estimativa')
        .then((valor) => valor != null ? json.decode(valor) : {});

    return {
      ...infoSinc,
      'naoSincronizados': naoSincronizadas,
      'naoSincronizadosOutras': naoSincronizadasOutras,
    };
  }

  Future<void> salvaInfo({@required Map<String, dynamic> info}) async {
    await preferenciaRepository.salvar(
      idPreferencia: 'sinc-out-estimativa',
      valorPreferencia: json.encode(info),
    );
  }
}
