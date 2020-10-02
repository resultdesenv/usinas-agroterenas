import 'package:apontamento/comum/modelo/estimativa_modelo.dart';
import 'package:equatable/equatable.dart';

class ApontamentoEstimativaState extends Equatable {
  final List<EstimativaModelo> apontamentos;
  final bool loading;
  final String mensagemErro;
  final bool criacao;

  ApontamentoEstimativaState({
    this.apontamentos = const [],
    this.loading = false,
    this.mensagemErro,
    this.criacao = false,
  });

  ApontamentoEstimativaState juntar({
    List<EstimativaModelo> apontamentos,
    bool loading,
    bool criacao,
    String mensagemErro,
  }) {
    return ApontamentoEstimativaState(
      apontamentos: apontamentos ?? this.apontamentos,
      loading: loading ?? this.loading,
      criacao: criacao ?? this.criacao,
      mensagemErro: mensagemErro,
    );
  }

  @override
  List<Object> get props => [apontamentos, loading, mensagemErro, criacao];
}
