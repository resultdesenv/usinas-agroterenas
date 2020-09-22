import 'package:apontamento/comun/modelo/sincronizacao_out_model.dart';
import 'package:flutter/cupertino.dart';

abstract class SincronizacaoOutEvent {}

class IniciaEstadoSincronizacaoOut extends SincronizacaoOutEvent {
  final List<SincronizacaoOutModel> sincronizacaoItens;

  IniciaEstadoSincronizacaoOut({@required this.sincronizacaoItens});
}

class SincronizarOut extends SincronizacaoOutEvent {
  final int index;

  SincronizarOut({@required this.index});
}

class SincronizarTudo extends SincronizacaoOutEvent {}
