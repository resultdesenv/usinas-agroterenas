import 'package:apontamento/comum/db/db.dart';
import 'package:apontamento/comum/modelo/estimativa_modelo.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class RepositorioEstimativa {
  final Db db;

  RepositorioEstimativa({@required this.db});

  Future<List<EstimativaModelo>> get({
    Map<String, dynamic> filtros,
  }) async {
    final banco = await db.get();
    final lista = await banco.query(
      'apont_estimativa',
      where: filtros != null && filtros.keys.length > 0
          ? filtros.keys
              .map((e) => !['status', 'date(dtHistorico)'].contains(e)
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

  Future<bool> salvar(List<EstimativaModelo> estimativas) async {
    final banco = await db.get();

    for (final item in estimativas) {
      await banco.insert(
        'apont_estimativa',
        item.paraMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return true;
  }

  Future<bool> atualizarItens(List<EstimativaModelo> estimativas) async {
    final banco = await db.get();
    print('update');
    for (final item in estimativas) {
      await banco.update(
        'apont_estimativa',
        item.paraMap(),
        where:
            'dispositivo = ? AND instancia = ? AND noBoletim = ? AND noSeq = ? AND cdUpnivel1 = ? AND cdUpnivel2 = ? AND cdUpnivel3 = ?',
        whereArgs: [
          item.dispositivo,
          item.instancia,
          item.noBoletim,
          item.noSeq,
          item.cdUpnivel1,
          item.cdUpnivel2,
          item.cdUpnivel3,
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
            'dispositivo = ? AND instancia = ? AND noBoletim = ? AND noSeq = ? AND cdUpnivel1 = ? AND cdUpnivel2 = ? AND cdUpnivel3 = ?',
        whereArgs: [
          item.dispositivo,
          item.instancia,
          item.noBoletim,
          item.noSeq,
          item.cdUpnivel1,
          item.cdUpnivel2,
          item.cdUpnivel3,
        ],
      );
    }
    return true;
  }
}
