import 'package:apontamento/comun/db/db.dart';
import 'package:apontamento/comun/modelo/upnivel3_model.dart';
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
    final banco = await db.get();
    final lista = await banco.query(
      'upnivel3',
      columns: colunasUpNivel3,
      where: filtros != null && filtros.keys.length > 0
          ? filtros.keys
              .map((e) => !['(date(dtUltimoCorte)'].contains(e)
                  ? "$e = '${filtros[e]}'"
                  : '$e ${filtros[e]}')
              .join(' AND ')
          : null,
    );

    return lista.map((e) => UpNivel3Model.fromJson(e)).toList();
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
