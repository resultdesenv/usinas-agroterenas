import 'package:apontamento/comun/modelo/estimativa_modelo.dart';
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

class ApagarApontamentos extends ApontamentoEstimativaEvento {
  final BuildContext context;

  ApagarApontamentos({@required this.context});
}

class SalvarApontamentos extends ApontamentoEstimativaEvento {
  final BuildContext context;

  SalvarApontamentos({@required this.context});
}
