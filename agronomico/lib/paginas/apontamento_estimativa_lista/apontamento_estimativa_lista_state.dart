import 'package:agronomico/comum/modelo/estimativa_modelo.dart';
import 'package:equatable/equatable.dart';

class ApontamentoEstimativaListaState extends Equatable {
  final bool carregando;
  final List<EstimativaModelo> estimativas;
  final String mensagemErro;
  final List<EstimativaModelo> estimativasSelecionadas;
  final Map<String, dynamic> filtros;
  final Map<String, List<String>> listaDropDown;

  ApontamentoEstimativaListaState({
    this.carregando = false,
    this.estimativas = const [],
    this.estimativasSelecionadas = const [],
    this.mensagemErro,
    this.filtros = const {},
    this.listaDropDown = const {},
  });

  ApontamentoEstimativaListaState juntar({
    bool carregando,
    List<EstimativaModelo> estimativas,
    List<EstimativaModelo> estimativasSelecionadas,
    String mensagemErro,
    Map<String, dynamic> filtros,
    Map<String, List<String>> listaDropDown,
  }) {
    return ApontamentoEstimativaListaState(
      estimativas: estimativas ?? this.estimativas,
      carregando: carregando ?? this.carregando,
      filtros: filtros ?? this.filtros,
      listaDropDown: listaDropDown ?? this.listaDropDown,
      estimativasSelecionadas:
          estimativasSelecionadas ?? this.estimativasSelecionadas,
      mensagemErro: mensagemErro ?? null,
    );
  }

  @override
  List<Object> get props => [
        carregando,
        estimativas,
        estimativasSelecionadas,
        mensagemErro,
        filtros,
        listaDropDown,
      ];
}
