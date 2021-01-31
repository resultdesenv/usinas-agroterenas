import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:flutter/cupertino.dart';

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

class MontaBoletimBroca extends ApontamentoBrocaListaEvent {
  final int cdFunc;
  final int noSeq;
  final int noBoletim;
  final int dispositivo;
  final List<UpNivel3Model> upniveis;

  MontaBoletimBroca({
    @required this.cdFunc,
    @required this.dispositivo,
    @required this.noBoletim,
    @required this.noSeq,
    @required this.upniveis,
  });
}
