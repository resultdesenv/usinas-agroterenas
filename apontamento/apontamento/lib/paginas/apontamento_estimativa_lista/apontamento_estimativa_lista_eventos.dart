import 'package:apontamento/comun/modelo/estimativa_modelo.dart';
import 'package:flutter/cupertino.dart';

abstract class ApontamentoEstimativaListaEvento {}

class CarregarListas extends ApontamentoEstimativaListaEvento {
  final Map<String, dynamic> filtros;
  final bool salvaFiltros;

  CarregarListas({this.filtros = const {}, this.salvaFiltros = true});
}

class MudaSelecaoEstimativa extends ApontamentoEstimativaListaEvento {
  final EstimativaModelo estimativa;

  MudaSelecaoEstimativa({@required this.estimativa});
}

class RemoverEstimativasSelecionadas extends ApontamentoEstimativaListaEvento {}

class AlterarFiltroEstimativas extends ApontamentoEstimativaListaEvento {
  final String chave;
  final String valor;

  AlterarFiltroEstimativas({@required this.chave, @required this.valor});
}

class IniciarListaEstimativas extends ApontamentoEstimativaListaEvento {}
