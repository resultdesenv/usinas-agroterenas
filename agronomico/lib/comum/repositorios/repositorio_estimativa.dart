import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/modelo/estimativa_modelo.dart';
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
      orderBy: 'noBoletim DESC',
    );

    return EstimativaModelo.converterListaMapObjeto(lista);
  }

  Future<List<String>> buscaUp2() async {
    final banco = await db.get();
    final List<String> up2 = await banco
        .query(
          'apont_estimativa',
          distinct: true,
          columns: ['cdUpnivel2'],
          orderBy: 'cdUpnivel2 ASC',
        )
        .then((itens) => itens.map((e) => e['cdUpnivel2'].toString()).toList());
    return ['', ...up2];
  }

  Future<List<String>> buscaUp1({
    @required String up2,
  }) async {
    final banco = await db.get();
    final List<String> up1 = await banco
        .query(
          'apont_estimativa',
          distinct: true,
          columns: ['cdUpnivel1'],
          where: 'cdUpnivel1 = ? AND cdUpnivel2 = ?',
          whereArgs: [up2],
          orderBy: 'cdUpnivel1 ASC',
        )
        .then((itens) => itens.map((e) => e['cdUpnivel1'].toString()).toList());
    return ['', ...up1];
  }

  Future<List<String>> buscaSafra({
    @required String up1,
    @required String up2,
  }) async {
    final banco = await db.get();
    final List<String> safra = await banco
        .query(
          'apont_estimativa',
          distinct: true,
          columns: ['cdSafra'],
          where: 'cdUpnivel1 = ? AND cdUpnivel2 = ?',
          whereArgs: [up1, up2],
          orderBy: 'cdSafra ASC',
        )
        .then((itens) => itens.map((e) => e['cdSafra'].toString()).toList());
    return ['', ...safra];
  }

  Future<List<String>> buscaUp3({
    @required String safra,
    @required String up1,
    @required String up2,
  }) async {
    final banco = await db.get();
    final List<String> up3 = await banco
        .query(
          'apont_estimativa',
          distinct: true,
          columns: ['cdUpnivel3'],
          where: 'cdSafra = ? AND cdUpnivel1 = ? AND cdUpnivel2 = ?',
          whereArgs: [safra, up1, up2],
          orderBy: 'cdUpnivel3 ASC',
        )
        .then((itens) => itens.map((e) => e['cdUpnivel3'].toString()).toList());
    return ['', ...up3];
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
        {
          ...item.paraMap(),
          'status': 'P',
          'dtStatus': DateTime.now().toIso8601String(),
        },
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
        {
          ...item.paraMap(),
          'status': 'P',
          'dtStatus': DateTime.now().toIso8601String(),
        },
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
