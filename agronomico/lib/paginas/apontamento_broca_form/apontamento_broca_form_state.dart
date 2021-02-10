import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:agronomico/comum/modelo/sequencia_model.dart';
import 'package:agronomico/comum/modelo/tipo_fitossanidade_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class ApontamentoBrocaFormState extends Equatable {
  final List<ApontBrocaModel> brocas;
  final bool carregando;
  final String mensagemErro;
  final List<TipoFitossanidadeModel> tiposFitossanidade;
  final bool voltarParaListagem;
  final bool novoApontamento;
  final int tipoFitossanidade;
  final bool salvo;
  final ApontBrocaModel primeiraBroca;
  final int canas;
  final Sequencia sequencia;

  ApontamentoBrocaFormState({
    this.brocas = const [],
    this.tiposFitossanidade = const [],
    this.carregando = false,
    this.mensagemErro,
    this.voltarParaListagem = false,
    this.novoApontamento = false,
    this.tipoFitossanidade,
    this.salvo = true,
    this.primeiraBroca,
    this.canas,
    this.sequencia,
  });

  ApontamentoBrocaFormState juntar({
    bool carregando,
    int tipoFitossanidade,
    bool voltarParaListagem,
    List<ApontBrocaModel> brocas,
    List<TipoFitossanidadeModel> tiposFitossanidade,
    String mensagemErro,
    bool novoApontamento,
    bool salvo,
    ApontBrocaModel primeiraBroca,
    int canas,
    Sequencia sequencia,
  }) =>
      ApontamentoBrocaFormState(
        brocas: brocas ?? this.brocas,
        tipoFitossanidade: tipoFitossanidade ?? this.tipoFitossanidade,
        carregando: carregando ?? this.carregando,
        tiposFitossanidade: tiposFitossanidade ?? this.tiposFitossanidade,
        mensagemErro: mensagemErro,
        voltarParaListagem: voltarParaListagem,
        novoApontamento: novoApontamento ?? this.novoApontamento,
        salvo: salvo ?? this.salvo,
        primeiraBroca: primeiraBroca ?? this.primeiraBroca,
        canas: canas ?? this.canas,
        sequencia: sequencia ?? this.sequencia,
      );

  @override
  List<Object> get props => [
        brocas,
        carregando,
        tiposFitossanidade,
        voltarParaListagem,
        novoApontamento,
        tipoFitossanidade,
        salvo,
        primeiraBroca,
        canas,
        sequencia,
      ];
}
