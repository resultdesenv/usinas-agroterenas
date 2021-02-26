import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:flutter/foundation.dart';

abstract class TalhaoUnicoEvent {}

class IniciarTalhaoUnico extends TalhaoUnicoEvent {}

class BuscaSafra extends TalhaoUnicoEvent {
  final String up2;

  BuscaSafra({@required this.up2});
}

class BuscaListaTalhoes extends TalhaoUnicoEvent {
  final Map<String, dynamic> filtros;
  final bool salvaFiltros;

  BuscaListaTalhoes({
    @required this.filtros,
    this.salvaFiltros = true,
  });
}

class AlteraFiltros extends TalhaoUnicoEvent {
  final Map<String, dynamic> filtros;

  AlteraFiltros({@required this.filtros});
}

class EscolheTalhao extends TalhaoUnicoEvent {
  final UpNivel3Model talhao;
  final int cdFunc;
  final int qtCanas;

  EscolheTalhao({
    @required this.talhao,
    @required this.cdFunc,
    @required this.qtCanas,
  });
}
