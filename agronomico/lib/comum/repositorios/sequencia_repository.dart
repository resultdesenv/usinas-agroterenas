import 'dart:convert';

import 'package:agronomico/comum/modelo/dispositivo_model.dart';
import 'package:agronomico/comum/modelo/empresa_model.dart';
import 'package:agronomico/comum/modelo/sequencia_model.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_base.dart';
import 'package:agronomico/comum/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:agronomico/comum/utilidades/custom_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'package:agronomico/comum/db/db.dart';
import 'package:sqflite/sqflite.dart';

class SincronizacaoSequenciaRepository extends SincronizacaoBase<Sequencia> {
  Dio dio;
  final Db db;
  final PreferenciaRepository preferenciaRepository;
  final SincronizacaoHistoricoRepository sincronizacaoHistoricoRepository;

  SincronizacaoSequenciaRepository({
    @required this.db,
    @required this.dio,
    @required this.preferenciaRepository,
    @required this.sincronizacaoHistoricoRepository,
  });

  updateDio(Dio dio) {
    this.dio = dio;
  }

  Future<List<EmpresaModel>> _buscarEmpresas() async {
    final dbInstance = await db.get();
    final empresasJson = await dbInstance.query('empresa');
    return empresasJson
        .map<EmpresaModel>((empresaJson) => EmpresaModel.fromJson(empresaJson))
        .toList();
  }

  Future<Sequencia> salvarSequencia({@required Sequencia sequencia}) async {
    final dbInstance = await db.get();
    await dbInstance.insert(
      'sequencia',
      sequencia.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(await dbInstance.query('sequencia'));
    return sequencia;
  }

  Future<Sequencia> buscarSequencia({EmpresaModel empresa}) async {
    final dbInstance = await db.get();
    final sequenciaJson = await dbInstance.query('sequencia',
        where: "instancia = '${empresa.cdInstManfro}'");
    if (sequenciaJson.length == 0)
      throw CustomException('Sequencia não encontrada');
    return Sequencia.fromJson(sequenciaJson[0]);
  }

  Future<List<Sequencia>> _buscarListaSequenciaApi({
    @required String token,
    @required List<EmpresaModel> empresas,
    @required String idDispositivo,
  }) async {
    final List<Sequencia> listaSequencia = [];
    for (final empresa in empresas) {
      final sequencia = await buscarSequenciaApi(
          instancia: empresa.cdInstManfro,
          idDispositivo: idDispositivo,
          token: token);
      listaSequencia.add(sequencia);
    }
    return listaSequencia;
  }

  Future<List<Sequencia>> buscarListaSequenciaDb() async {
    final dbInstance = await db.get();
    final sequenciasJson = await dbInstance.query('sequencia');
    return sequenciasJson
        .map((sequenciaJson) => Sequencia.fromJson(sequenciaJson))
        .toList();
  }

  Future<Sequencia> buscarSequenciaApi({
    @required String token,
    @required String instancia,
    @required String idDispositivo,
  }) async {
    final sequenciaJson = await dio.get(
        '/agt-api-pims/api/dispositivo/sequencia/aplicativo/idDispositivo/$idDispositivo/instancia/$instancia/idAplicativo/96',
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }));
    return Sequencia.fromJson(sequenciaJson.data);
  }

  Future<void> index(
    String token, {
    String cdInstManfro,
    String cdSafra,
    String nivel2,
  }) async {
    final dataInicial = DateTime.now();
    String dispositivoTexto =
        await preferenciaRepository.get(idPreferencia: 'dispositivo');
    if (dispositivoTexto == null)
      throw CustomException('Dispositivo não cadastrado');
    DispositivoModel dispositivoModel =
        DispositivoModel.fromJson(jsonDecode(dispositivoTexto));
    await _limpar();
    final empresas = await _buscarEmpresas();
    final sequencias = await _buscarListaSequenciaApi(
        token: token,
        empresas: empresas,
        idDispositivo: dispositivoModel.idDispositivo.toString());
    final dataFinal = DateTime.now();
    await _salvar(
        sequencias,
        Duration(
            milliseconds: dataFinal.millisecondsSinceEpoch -
                dataInicial.millisecondsSinceEpoch));
  }

  Future<void> _limpar() async {
    final dbInstancia = await db.get();
    await dbInstancia.delete('sequencia');
  }

  Future<void> _salvar(List<Sequencia> sequencias, Duration duracao) async {
    final dbInstancia = await db.get();
    for (final sequencia in sequencias) {
      await dbInstancia.insert('sequencia', sequencia.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await sincronizacaoHistoricoRepository.salvarDataAtualizacao(
        'sequencia', duracao, sequencias.length);
  }
}
