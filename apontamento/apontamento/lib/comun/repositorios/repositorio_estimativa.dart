import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/modelo/estimativa_modelo.dart';
import 'package:apontamento/comun/repositorios/repositorio_base.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

final colunasEstimativa = [
  'cdEstagio',
  'cdSafra',
  'cdTpPropr',
  'cdUpnivel1',
  'cdUpnivel2',
  'cdUpnivel3',
  'cdVaried',
  'dtUltimoCorte',
  'instancia',
  'precipitacao',
  'qtAreaProd',
  'producaoSafraAnt',
  'sphenophous',
  'tch0',
  'tch1',
  'tch2',
  'tch3',
  'tch4',
  'cdFunc',
  'noBoletim',
  'noSeq',
  'dispositivo',
  'dtHistorico',
  'tchAnoPassado',
  'tchAnoRetrasado',
  'status',
  'dtStatus',
];

class RepositorioEstimativa implements RepositorioBase<EstimativaModelo> {
  final Db db;
  final Dio dio;

  RepositorioEstimativa({@required this.db, @required this.dio});

  Future<List<EstimativaModelo>> get({
    Map<String, dynamic> filtros,
  }) async {
    final banco = await db.get();
    final lista = await banco.query(
      'apont_estimativa',
      columns: colunasEstimativa,
      where: filtros != null && filtros.keys.length > 0
          ? filtros.keys
              .map((e) => !['status', '(date(dtHistorico)'].contains(e)
                  ? "$e = '${filtros[e]}'"
                  : '$e ${filtros[e]}')
              .join(' AND ')
          : null,
    );

    return EstimativaModelo.converterListaMapObjeto(lista);
  }

  Future<Map<String, List<String>>> buscaDropDow() async {
    final banco = await db.get();

    final safra = await banco.query(
      'apont_estimativa',
      distinct: true,
      columns: ['cdSafra'],
    ).then((itens) => itens.map((e) => e['cdSafra'].toString()).toList());

    final up1 = await banco.query(
      'apont_estimativa',
      distinct: true,
      columns: ['cdUpnivel1'],
    ).then((itens) => itens.map((e) => e['cdUpnivel1']).toList());

    final up2 = await banco.query(
      'apont_estimativa',
      distinct: true,
      columns: ['cdUpnivel2'],
    ).then((itens) => itens.map((e) => e['cdUpnivel2']).toList());

    final up3 = await banco.query(
      'apont_estimativa',
      distinct: true,
      columns: ['cdUpnivel3'],
    ).then((itens) => itens.map((e) => e['cdUpnivel3']).toList());

    return {
      'cdSafra': ['', ...safra],
      'cdUpnivel1': ['', ...up1],
      'cdUpnivel2': ['', ...up2],
      'cdUpnivel3': ['', ...up3],
    };
  }

  Future<bool> sincronizarSaida() async {
    final banco = await db.get();
    final estimativas =
        await banco.query('apont_estimativa', columns: colunasEstimativa);
    await dio.post('/estimativa/insert', data: estimativas);
    return true;
  }

  Future<bool> salvar(List<EstimativaModelo> estimativas) async {
    final banco = await db.get();

    await banco.delete('apont_estimativa');

    for (final item in estimativas) {
      await banco.insert('apont_estimativa', item.paraMap());
    }
    return true;
  }

  Future<bool> atualizarItens(List<EstimativaModelo> estimativas) async {
    final banco = await db.get();

    for (final item in estimativas) {
      await banco.update(
        'apont_estimativa',
        item.paraMap(),
        where:
            'dispositivo = ? AND instancia = ? AND noBoletim = ? AND noSeq = ?',
        whereArgs: [
          item.dispositivo,
          item.instancia,
          item.noBoletim,
          item.noSeq,
        ],
      );
    }
    return true;
  }

  Future<bool> removerItens(List<EstimativaModelo> estimativas) async {
    final banco = await db.get();

    for (var item in estimativas) {
      await banco.delete(
        'apont_estimativa',
        where:
            'dispositivo = ? AND instancia = ? AND noBoletim = ? AND noSeq = ?',
        whereArgs: [
          item.dispositivo,
          item.instancia,
          item.noBoletim,
          item.noSeq,
        ],
      );
    }
    return true;
  }
}
