import 'package:agronomico/comum/modelo/estimativa_modelo.dart';
import 'package:flutter/cupertino.dart';

abstract class ApontamentoEstimativaListaEvent {}

class CarregarListas extends ApontamentoEstimativaListaEvent {
  final Map<String, dynamic> filtros;
  final bool salvaFiltros;

  CarregarListas({this.filtros = const {}, this.salvaFiltros = true});
}

class MudaSelecaoEstimativa extends ApontamentoEstimativaListaEvent {
  final EstimativaModelo estimativa;

  MudaSelecaoEstimativa({@required this.estimativa});
}

class RemoverEstimativasSelecionadas extends ApontamentoEstimativaListaEvent {}

class AlterarFiltroEstimativas extends ApontamentoEstimativaListaEvent {
  final String chave;
  final String valor;

  AlterarFiltroEstimativas({@required this.chave, @required this.valor});
}

class IniciarListaEstimativas extends ApontamentoEstimativaListaEvent {}

class CheckAllEstimativaLista extends ApontamentoEstimativaListaEvent {
  final bool valor;

  CheckAllEstimativaLista({@required this.valor});
}

class BuscaSafra extends ApontamentoEstimativaListaEvent {
  final String up1;

  BuscaSafra({@required this.up1});
}

class BuscaUpnivel1 extends ApontamentoEstimativaListaEvent {
  final String up2;

  BuscaUpnivel1({@required this.up2});
}

class BuscaUpnivel3 extends ApontamentoEstimativaListaEvent {
  final String safra;

  BuscaUpnivel3({@required this.safra});
}
