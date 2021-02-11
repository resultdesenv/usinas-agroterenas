import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:flutter/foundation.dart';

abstract class ApontamentoBrocaListaEvent {}

class IniciaBrocaLista extends ApontamentoBrocaListaEvent {}

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

class BuscaUpnivel1 extends ApontamentoBrocaListaEvent {
  final String up2;

  BuscaUpnivel1({@required this.up2});
}

class BuscaUpnivel3 extends ApontamentoBrocaListaEvent {
  final String safra;

  BuscaUpnivel3({@required this.safra});
}

class AlteraSelecaoBroca extends ApontamentoBrocaListaEvent {
  final ApontBrocaModel broca;
  final bool value;

  AlteraSelecaoBroca({@required this.broca, @required this.value});
}

class RemoverBrocas extends ApontamentoBrocaListaEvent {}
