import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class TalhaoUnicoState extends Equatable {
  final bool loading;
  final String mensagemErro;
  final Map<String, dynamic> filtros;
  final Map<String, List<String>> listaDropDown;
  final List<UpNivel3Model> talhoes;

  TalhaoUnicoState({
    this.loading = false,
    this.filtros = const {},
    this.listaDropDown = const {},
    this.talhoes = const [],
    this.mensagemErro,
  });

  TalhaoUnicoState juntar({
    bool loading,
    Map<String, dynamic> filtros,
    Map<String, dynamic> listaDropDown,
    List<UpNivel3Model> talhoes,
    String mensagemErro,
  }) =>
      TalhaoUnicoState(
        loading: loading ?? this.loading,
        filtros: filtros ?? this.filtros,
        listaDropDown: listaDropDown ?? this.listaDropDown,
        talhoes: talhoes ?? this.talhoes,
        mensagemErro: mensagemErro,
      );

  @override
  List<Object> get props => [
        loading,
        filtros,
        listaDropDown,
        talhoes,
        mensagemErro,
      ];
}
