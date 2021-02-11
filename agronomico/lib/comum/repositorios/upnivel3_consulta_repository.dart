import 'package:agronomico/comum/db/db.dart';
import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:flutter/material.dart';

final colunasUpNivel3 = [
  'cdSafra',
  'cdUpnivel1',
  'cdUpnivel2',
  'cdUpnivel3',
  'cdTpPropr',
  'deTpPropr',
  'cdVaried',
  'deVaried',
  'cdEstagio',
  'deEstagio',
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
  'tchAnoPassado',
  'tchAnoRetrasado',
];

class UpNivel3ConsultaRepository {
  final Db db;

  UpNivel3ConsultaRepository({@required this.db});

  Future<List<UpNivel3Model>> get({
    Map<String, dynamic> filtros,
  }) async {
    print(filtros);
    final banco = await db.get();
    final lista = await banco.query(
      'upnivel3',
      columns: colunasUpNivel3,
      where: filtros != null && filtros.keys.length > 0
          ? filtros.keys
              .map((e) => !['date(dtUltimoCorte)'].contains(e)
                  ? "$e = '${filtros[e]}'"
                  : '$e ${filtros[e]}')
              .join(' AND ')
          : null,
    );
    return lista.map((e) => UpNivel3Model.fromJson(e)).toList();
  }

  Future<UpNivel3Model> getByPks({
    @required String cdUpnivel1,
    @required String cdUpnivel2,
    @required String cdUpnivel3,
    @required int cdSafra,
  }) async {
    final banco = await db.get();
    final UpNivel3Model upnivel = await banco.query(
      'upnivel3',
      where:
          'cdUpnivel1 = ? AND cdUpnivel2 = ? AND cdUpnivel3 = ? AND cdSafra = ?',
      whereArgs: [cdUpnivel1, cdUpnivel2, cdUpnivel3, cdSafra],
    ).then((lista) =>
        lista.length > 0 ? UpNivel3Model.fromJson(lista.first) : null);
    return upnivel;
  }

  Future<List<String>> buscaUp2() async {
    final banco = await db.get();
    final List<String> up2 = await banco
        .query(
          'upnivel3',
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
          'upnivel3',
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
          'upnivel3',
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
          'upnivel3',
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
      'upnivel3',
      distinct: true,
      columns: ['cdSafra'],
    ).then((itens) => itens.map((e) => e['cdSafra'].toString()).toList());

    final up1 = await banco.query(
      'upnivel3',
      distinct: true,
      columns: ['cdUpnivel1'],
    ).then((itens) => itens.map((e) => e['cdUpnivel1']).toList());

    final up2 = await banco.query(
      'upnivel3',
      distinct: true,
      columns: ['cdUpnivel2'],
    ).then((itens) => itens.map((e) => e['cdUpnivel2']).toList());

    final up3 = await banco.query(
      'upnivel3',
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
}
