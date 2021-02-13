import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ApontBrocaConsultaRepository {
  final Db db;

  ApontBrocaConsultaRepository({@required this.db});

  Future<List<ApontBrocaModel>> get({
    Map<String, dynamic> filtros,
    int limite,
  }) async {
    final banco = await db.get();
    final lista = await banco.query(
      'apont_broca',
      where: filtros != null && filtros.keys.length > 0
          ? filtros.keys
              .map((e) => !['status', 'date(dtHistorico)'].contains(e)
                  ? ['cdUpnivel2', 'cdSafra'].contains(e)
                      ? "$e LIKE '%${filtros[e]}%'"
                      : "$e = '${filtros[e]}'"
                  : '$e ${filtros[e]}')
              .join(' AND ')
          : null,
      orderBy: 'noSequencia ASC',
      limit: limite,
    );

    return lista.map((e) => ApontBrocaModel.fromJson(e)).toList();
  }

  Future<List<ApontBrocaModel>> resumos({
    Map<String, dynamic> filtros,
  }) async {
    final banco = await db.get();
    final lista = await banco
        .query(
          'apont_broca',
          where: filtros != null && filtros.keys.length > 0
              ? filtros.keys
                  .map((e) => !['status', 'date(dtHistorico)'].contains(e)
                      ? ['cdUpnivel2', 'cdSafra'].contains(e)
                          ? "$e LIKE '%${filtros[e]}%'"
                          : "$e = '${filtros[e]}'"
                      : '$e ${filtros[e]}')
                  .join(' AND ')
              : null,
          orderBy: 'noBoletim DESC',
        )
        .then((l) => l.map((e) => ApontBrocaModel.fromJson(e)).toList());
    final List<ApontBrocaModel> listaAuxiliar = [];

    lista.forEach((broca) {
      final int indiceResumo = listaAuxiliar.indexWhere(
        (e) => e.noBoletim == broca.noBoletim,
      );
      if (indiceResumo != -1) {
        final resumo = listaAuxiliar[indiceResumo];
        listaAuxiliar[indiceResumo] = listaAuxiliar[indiceResumo].juntar(
          qtBrocados: resumo.qtBrocados + broca.qtBrocados,
          qtCanaPodr: resumo.qtCanaPodr + broca.qtCanaPodr,
          qtEntrPodr: resumo.qtEntrPodr + broca.qtEntrPodr,
          qtCanas: resumo.qtCanas + broca.qtCanas,
          qtCanasbroc: resumo.qtCanasbroc + broca.qtCanasbroc,
          qtEntrenos: resumo.qtEntrenos + broca.qtEntrenos,
        );
        return;
      }

      listaAuxiliar.add(broca);
    });

    return listaAuxiliar;
  }

  Future<List<String>> buscaUp2() async {
    final banco = await db.get();
    final List<String> up2 = await banco
        .query(
          'apont_broca',
          distinct: true,
          columns: ['cdUpnivel2'],
          orderBy: 'cdUpnivel2 ASC',
        )
        .then((itens) => itens.map((e) => e['cdUpnivel2'].toString()).toList());

    return ['', ...up2];
  }

  Future<List<String>> buscaUp1({@required String up2}) async {
    final banco = await db.get();
    final List<String> up1 = await banco
        .query(
          'apont_broca',
          distinct: true,
          columns: ['cdUpnivel1'],
          where: 'cdUpnivel2 = ?',
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
          'apont_broca',
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
          'apont_broca',
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
      'apont_broca',
      distinct: true,
      columns: ['cdSafra'],
    ).then((itens) => itens.map((e) => e['cdSafra'].toString()).toList());

    final up1 = await banco.query(
      'apont_broca',
      distinct: true,
      columns: ['cdUpnivel1'],
    ).then((itens) => itens.map((e) => e['cdUpnivel1']).toList());

    final up2 = await banco.query(
      'apont_broca',
      distinct: true,
      columns: ['cdUpnivel2'],
    ).then((itens) => itens.map((e) => e['cdUpnivel2']).toList());

    final up3 = await banco.query(
      'apont_broca',
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

  Future salvarUm(ApontBrocaModel broca) async {
    final banco = await db.get();
    await banco.insert(
      'apont_broca',
      {
        ...broca.toJson,
        'status': 'P',
        'dtStatus': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> salvar(List<ApontBrocaModel> brocas) async {
    final banco = await db.get();

    for (final item in brocas) {
      await banco.insert(
        'apont_broca',
        {
          ...item.toJson,
          'status': 'P',
          'dtStatus': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return true;
  }

  Future<bool> atualizarItens(List<ApontBrocaModel> brocas) async {
    final banco = await db.get();
    print('update');
    for (final item in brocas) {
      await banco.update(
        'apont_broca',
        {
          ...item.toJson,
          'status': 'P',
          'dtStatus': DateTime.now().toIso8601String(),
        },
        where:
            'dispositivo = ? AND instancia = ? AND noBoletim = ? AND noSeq = ? AND cdUpnivel1 = ? AND cdUpnivel2 = ? AND cdUpnivel3 = ?',
        whereArgs: [
          item.dispositivo,
          item.instancia,
          item.noBoletim,
          item.noSequencia,
          item.cdUpnivel1,
          item.cdUpnivel2,
          item.cdUpnivel3,
        ],
      );
    }
    return true;
  }

  Future<bool> removerItens(List<ApontBrocaModel> brocas) async {
    final banco = await db.get();

    for (var item in brocas) {
      await banco.delete(
        'apont_broca',
        where:
            'dispositivo = ? AND instancia = ? AND noBoletim = ? AND noSeq = ? AND cdUpnivel1 = ? AND cdUpnivel2 = ? AND cdUpnivel3 = ?',
        whereArgs: [
          item.dispositivo,
          item.instancia,
          item.noBoletim,
          item.noSequencia,
          item.cdUpnivel1,
          item.cdUpnivel2,
          item.cdUpnivel3,
        ],
      );
    }
    return true;
  }

  Future removerPorBoletim(int boletim) async {
    final banco = await db.get();
    await banco
        .delete('apont_broca', where: 'noBoletim = ?', whereArgs: [boletim]);
  }
}
