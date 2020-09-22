import 'package:apontamento/comun/modelo/upnivel3_model.dart';
import 'package:flutter/material.dart';

abstract class UpNivel3Event {}

class BuscaListaUpNivel3 extends UpNivel3Event {
  final Map<String, dynamic> filtros;
  final bool salvaFiltros;

  BuscaListaUpNivel3({
    this.filtros = const {},
    this.salvaFiltros = true,
  });
}

class MudaSelecaoUpNivel3 extends UpNivel3Event {
  final UpNivel3Model upnivel3;

  MudaSelecaoUpNivel3({@required this.upnivel3});
}

class AlterarFiltroUpNivel3 extends UpNivel3Event {
  final String chave;
  final String valor;

  AlterarFiltroUpNivel3({@required this.chave, @required this.valor});
}

class IniciarListaUpNivel3 extends UpNivel3Event {}

class ConfirmaSelecaoUpNivel3 extends UpNivel3Event {
  final BuildContext context;

  ConfirmaSelecaoUpNivel3({@required this.context});
}

class CheckAllUpNivel3 extends UpNivel3Event {
  final bool valor;

  CheckAllUpNivel3({@required this.valor});
}
