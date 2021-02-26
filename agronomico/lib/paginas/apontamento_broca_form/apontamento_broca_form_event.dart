import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:agronomico/comum/modelo/empresa_model.dart';
import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:flutter/cupertino.dart';

abstract class ApontamentoBrocaFormEvent {}

class IniciarFormBrocas extends ApontamentoBrocaFormEvent {
  final UpNivel3Model upnivel3;
  final int cdFunc;
  final int noBoletim;
  final int dispositivo;
  final bool novoApontamento;
  final String instancia;
  final EmpresaModel empresa;
  final int qtCanas;

  IniciarFormBrocas({
    @required this.upnivel3,
    @required this.cdFunc,
    @required this.noBoletim,
    @required this.dispositivo,
    @required this.instancia,
    @required this.empresa,
    this.qtCanas,
    this.novoApontamento = true,
  });
}

class AlteraTipoBroca extends ApontamentoBrocaFormEvent {
  final int cdFitoss;
  final List<ApontBrocaModel> brocas;

  AlteraTipoBroca({@required this.cdFitoss, @required this.brocas});
}

class AlteraDataBroca extends ApontamentoBrocaFormEvent {
  final DateTime data;
  final List<ApontBrocaModel> brocas;

  AlteraDataBroca({@required this.data, @required this.brocas});
}

class AlteraApontamento extends ApontamentoBrocaFormEvent {
  final int indiceBroca;
  final ApontBrocaModel broca;

  AlteraApontamento({
    @required this.indiceBroca,
    @required this.broca,
  });
}

class SalvarApontamentos extends ApontamentoBrocaFormEvent {
  final EmpresaModel empresa;
  final List<ApontBrocaModel> brocas;
  final bool voltar;
  final Future<bool> Function(int canasFaltantes) confirmaNaoApontadas;

  SalvarApontamentos({
    @required this.empresa,
    @required this.brocas,
    @required this.confirmaNaoApontadas,
    this.voltar = false,
  });
}

class AlteraQuantidade extends ApontamentoBrocaFormEvent {
  final int quantidade;
  final List<ApontBrocaModel> brocas;

  AlteraQuantidade({@required this.quantidade, @required this.brocas});
}

class MarcaParaSalvar extends ApontamentoBrocaFormEvent {
  final ApontBrocaModel broca;

  MarcaParaSalvar({@required this.broca});
}
