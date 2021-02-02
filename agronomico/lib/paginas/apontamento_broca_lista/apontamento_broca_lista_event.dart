import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:flutter/foundation.dart';

abstract class ApontamentoBrocaListaEvent {}

class BuscaListaBroca extends ApontamentoBrocaListaEvent {
  final Map<String, dynamic> filtros;
  final bool salvaFiltros;

  BuscaListaBroca({
    @required this.filtros,
    @required this.salvaFiltros,
  });
}

class AlterarFiltroBroca extends ApontamentoBrocaListaEvent {
  final String chave;
  final String valor;

  AlterarFiltroBroca({@required this.chave, @required this.valor});
}

class BuscaSafra extends ApontamentoBrocaListaEvent {
  final String up1;

  BuscaSafra({@required this.up1});
}

class BuscaUpnivel2 extends ApontamentoBrocaListaEvent {
  final String safra;

  BuscaUpnivel2({@required this.safra});
}

class BuscaUpnivel3 extends ApontamentoBrocaListaEvent {
  final String up2;

  BuscaUpnivel3({@required this.up2});
}

class AlteraSelecaoBroca extends ApontamentoBrocaListaEvent {
  final ApontBrocaModel broca;
  final bool value;

  AlteraSelecaoBroca({@required this.broca, @required this.value});
}

class RemoverBrocas extends ApontamentoBrocaListaEvent {}
