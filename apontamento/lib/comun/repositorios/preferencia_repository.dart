import 'package:apontamento/comun/db/db.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class PreferenciaRepository {
  final Db db;

  PreferenciaRepository({@required this.db});

  Future<String> get({@required String idPreferencia}) async {
    final banco = await db.get();
    final preferencia = await banco.query(
      'preferencia',
      where: 'idPreferencia = ?',
      whereArgs: [idPreferencia],
      limit: 1,
    );
    if (preferencia.length == 0) return null;
    return preferencia[0]['valorPreferencia'];
  }

  Future<void> salvar({
    @required String idPreferencia,
    @required dynamic valorPreferencia,
  }) async {
    final banco = await db.get();
    await banco.insert(
        'preferencia',
        {
          'idPreferencia': idPreferencia,
          'valorPreferencia': valorPreferencia,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
