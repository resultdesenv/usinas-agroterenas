import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class ApontamentoBrocaListaState extends Equatable {
  final bool carregando;
  final List<ApontBrocaModel> brocas;
  final String mensagemErro;
  final Map<String, dynamic> filtros;
  final Map<String, List<String>> listaDropDown;

  ApontamentoBrocaListaState({
    this.carregando = false,
    this.brocas = const [],
    this.mensagemErro,
    this.filtros = const {},
    this.listaDropDown = const {},
  });

  ApontamentoBrocaListaState juntar({
    bool carregando,
    List<ApontBrocaModel> brocas,
    String mensagemErro,
    Map<String, dynamic> filtros,
    Map<String, List<String>> listaDropDown,
  }) {
    return ApontamentoBrocaListaState(
      brocas: brocas ?? this.brocas,
      carregando: carregando ?? this.carregando,
      filtros: filtros ?? this.filtros,
      listaDropDown: listaDropDown ?? this.listaDropDown,
      mensagemErro: mensagemErro ?? null,
    );
  }

  @override
  List<Object> get props => [
        carregando,
        brocas,
        mensagemErro,
        filtros,
        listaDropDown,
      ];
}
