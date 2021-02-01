import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:flutter/cupertino.dart';

abstract class ApontamentoBrocaFormEvent {}

class IniciarFormBrocas extends ApontamentoBrocaFormEvent {
  final UpNivel3Model upnivel3;
  final int cdFunc;
  final int noBoletim;
  final int dispositivo;
  final bool novoApontamento;

  IniciarFormBrocas({
    @required this.upnivel3,
    @required this.cdFunc,
    @required this.noBoletim,
    @required this.dispositivo,
    this.novoApontamento = true,
  });
}

class AlteraTipoBroca extends ApontamentoBrocaFormEvent {
  final int cdFitoss;

  AlteraTipoBroca({@required this.cdFitoss});
}

class AlteraApontamento extends ApontamentoBrocaFormEvent {
  final int indiceBroca;
  final ApontBrocaModel broca;

  AlteraApontamento({
    @required this.indiceBroca,
    @required this.broca,
  });
}
