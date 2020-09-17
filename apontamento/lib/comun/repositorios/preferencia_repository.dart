import 'dart:convert';

import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/modelo/preferencia_model.dart';
import 'package:flutter/material.dart';

final colunaspreferencia = [
  'idPreferencia',
  'valorPreferencia',
];

class PreferenciaRepository {
  final Db db;

  PreferenciaRepository({@required this.db});

  Future<Map<String, String>> get({@required String idPreferencia}) async {
    final banco = await db.get();

    final preferencia = await banco.query(
      'preferencia',
      where: 'idPreferencia = ?',
      whereArgs: [idPreferencia],
      columns: colunaspreferencia,
      limit: 1,
    );

    Map<String, String> filtro;

    if (preferencia.length > 0) {
      filtro = Map();
      final Map<String, dynamic> map =
          json.decode(preferencia[0]['valorPreferencia']);
      map.keys.forEach((key) {
        filtro[key] = map[key];
      });
    }

    return filtro;
  }

  Future<bool> salvar({
    @required PreferenciaModel preferencia,
  }) async {
    final banco = await db.get();
    final existepreferencia =
        await get(idPreferencia: preferencia.idPreferencia);

    if (existepreferencia == null) {
      await banco.insert('preferencia', {
        ...preferencia.paraMap(),
        'valorPreferencia': preferencia.preferenciaParaString,
      });
    } else {
      await banco.update(
        'preferencia',
        {
          ...preferencia.paraMap(),
          'valorPreferencia': preferencia.preferenciaParaString
        },
        where: 'idPreferencia = ?',
        whereArgs: [preferencia.idPreferencia],
      );
    }

    return true;
  }
}
