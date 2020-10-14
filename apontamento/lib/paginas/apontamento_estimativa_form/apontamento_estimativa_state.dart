import 'package:apontamento/comum/modelo/estimativa_modelo.dart';
import 'package:equatable/equatable.dart';

class ApontamentoEstimativaState extends Equatable {
  final List<EstimativaModelo> apontamentos;
  final bool loading;
  final String mensagemErro;
  final bool criacao;
  final bool edicaoConcluida;

  ApontamentoEstimativaState({
    this.apontamentos = const [],
    this.loading = false,
    this.mensagemErro,
    this.criacao = false,
    this.edicaoConcluida = false,
  });

  ApontamentoEstimativaState juntar({
    List<EstimativaModelo> apontamentos,
    bool loading,
    bool criacao,
    bool edicaoConcluida,
    String mensagemErro,
  }) {
    return ApontamentoEstimativaState(
      apontamentos: apontamentos ?? this.apontamentos,
      loading: loading ?? this.loading,
      criacao: criacao ?? this.criacao,
      edicaoConcluida: edicaoConcluida ?? this.edicaoConcluida,
      mensagemErro: mensagemErro,
    );
  }

  @override
  List<Object> get props =>
      [apontamentos, loading, mensagemErro, criacao, edicaoConcluida];
}
