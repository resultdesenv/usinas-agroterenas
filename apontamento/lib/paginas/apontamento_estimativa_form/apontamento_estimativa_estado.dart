import 'package:apontamento/comun/modelo/estimativa_modelo.dart';
import 'package:equatable/equatable.dart';

class ApontamentoEstimativaEstado extends Equatable {
  final List<EstimativaModelo> apontamentos;
  final bool loading;
  final String mensagemErro;
  final bool criacao;

  ApontamentoEstimativaEstado({
    this.apontamentos = const [],
    this.loading = false,
    this.mensagemErro,
    this.criacao = false,
  });

  ApontamentoEstimativaEstado juntar({
    List<EstimativaModelo> apontamentos,
    bool loading,
    bool criacao,
    String mensagemErro,
  }) {
    return ApontamentoEstimativaEstado(
      apontamentos: apontamentos ?? this.apontamentos,
      loading: loading ?? this.loading,
      criacao: criacao ?? this.criacao,
      mensagemErro: mensagemErro,
    );
  }

  @override
  List<Object> get props => [apontamentos, loading, mensagemErro, criacao];
}
