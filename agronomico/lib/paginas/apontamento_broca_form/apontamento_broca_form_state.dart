import 'package:agronomico/comum/modelo/apont_broca_model.dart';
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

  ApontamentoBrocaFormState({
    this.brocas = const [],
    this.tiposFitossanidade = const [],
    this.carregando = false,
    this.mensagemErro,
    this.voltarParaListagem = false,
    this.novoApontamento = false,
    this.tipoFitossanidade,
  });

  ApontamentoBrocaFormState juntar({
    bool carregando,
    int tipoFitossanidade,
    bool voltarParaListagem,
    List<ApontBrocaModel> brocas,
    List<TipoFitossanidadeModel> tiposFitossanidade,
    String mensagemErro,
    bool novoApontamento,
  }) =>
      ApontamentoBrocaFormState(
        brocas: brocas ?? this.brocas,
        tipoFitossanidade: tipoFitossanidade ?? this.tipoFitossanidade,
        carregando: carregando ?? this.carregando,
        tiposFitossanidade: tiposFitossanidade ?? this.tiposFitossanidade,
        mensagemErro: mensagemErro,
        voltarParaListagem: voltarParaListagem,
        novoApontamento: novoApontamento ?? this.novoApontamento,
      );

  @override
  List<Object> get props => [
        brocas,
        carregando,
        tiposFitossanidade,
        voltarParaListagem,
        novoApontamento,
        tipoFitossanidade,
      ];
}
