import 'package:apontamento/comun/sincronizacao/sincronizacao_out_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SincronizacaoOutModel extends Equatable {
  final String titulo;
  final int naoSincronizados;
  final bool naoSincronizadosOutras;
  final String dataUltimaSincronizacao;
  final String duracaoSincronizacao;
  final int quantidadeSincronizada;
  final SincronizacaoOutRepository repositorio;
  final String instancia;
  final bool carregando;

  SincronizacaoOutModel({
    @required this.titulo,
    @required this.repositorio,
    @required this.instancia,
    this.naoSincronizados,
    this.naoSincronizadosOutras,
    this.dataUltimaSincronizacao,
    this.duracaoSincronizacao,
    this.quantidadeSincronizada,
    this.carregando = false,
  });

  Future<void> sincronizar({@required String token}) async {
    try {
      await repositorio.sincronizar(token: token);
    } catch (e) {
      print(e);
      throw Exception('Erro ao sincronizar $titulo');
    }
  }

  Future<SincronizacaoOutModel> atualizaInfo() async {
    final info = await repositorio.buscaInfo(instancia: instancia);

    return SincronizacaoOutModel(
      titulo: titulo,
      repositorio: repositorio,
      instancia: instancia,
      dataUltimaSincronizacao: info['dataUltimaSincronizacao'],
      naoSincronizados: info['naoSincronizados'],
      naoSincronizadosOutras: info['naoSincronizadosOutras'],
      duracaoSincronizacao: info['duracaoSincronizacao'],
      quantidadeSincronizada: info['quantidadeSincronizada'],
    );
  }

  SincronizacaoOutModel juntar({
    String titulo,
    int naoSincronizados,
    bool naoSincronizadosOutras,
    String dataUltimaSincronizacao,
    String duracaoSincronizacao,
    int quantidadeSincronizada,
    SincronizacaoOutRepository repositorio,
    String instancia,
    bool carregando,
  }) {
    return SincronizacaoOutModel(
      titulo: titulo ?? this.titulo,
      naoSincronizados: naoSincronizados ?? this.naoSincronizados,
      naoSincronizadosOutras:
          naoSincronizadosOutras ?? this.naoSincronizadosOutras,
      dataUltimaSincronizacao:
          dataUltimaSincronizacao ?? this.dataUltimaSincronizacao,
      duracaoSincronizacao: duracaoSincronizacao ?? this.duracaoSincronizacao,
      quantidadeSincronizada:
          quantidadeSincronizada ?? this.quantidadeSincronizada,
      repositorio: repositorio ?? this.repositorio,
      instancia: instancia ?? this.instancia,
      carregando: carregando ?? this.carregando,
    );
  }

  @override
  List<Object> get props => [
        titulo,
        naoSincronizados,
        naoSincronizadosOutras,
        repositorio,
        dataUltimaSincronizacao,
        duracaoSincronizacao,
        quantidadeSincronizada,
        instancia,
        carregando,
      ];
}
