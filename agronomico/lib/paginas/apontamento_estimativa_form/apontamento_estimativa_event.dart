import 'package:agronomico/comum/modelo/empresa_model.dart';
import 'package:agronomico/comum/modelo/estimativa_modelo.dart';
import 'package:flutter/cupertino.dart';

abstract class ApontamentoEstimativaEvento {}

class AdicionarApontamento extends ApontamentoEstimativaEvento {
  final List<EstimativaModelo> apontamentos;
  final String mensagemInicial;

  AdicionarApontamento({@required this.apontamentos, this.mensagemInicial});
}

class EditarApontamento extends ApontamentoEstimativaEvento {
  final EstimativaModelo apontamento;
  final int indice;

  EditarApontamento({@required this.apontamento, @required this.indice});
}

class ApagarApontamentos extends ApontamentoEstimativaEvento {}

class SalvarApontamentos extends ApontamentoEstimativaEvento {
  final EmpresaModel empresa;
  final List<EstimativaModelo> estimativas;

  SalvarApontamentos({@required this.empresa, @required this.estimativas});
}

class ReplicarApontamentos extends ApontamentoEstimativaEvento {
  final String tch0;
  final String tch1;
  final String tch2;
  final String tch3;
  final String tch4;

  ReplicarApontamentos({
    @required this.tch0,
    @required this.tch1,
    @required this.tch2,
    @required this.tch3,
    @required this.tch4,
  });
}
