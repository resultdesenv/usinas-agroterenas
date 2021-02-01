import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:agronomico/comum/modelo/tipo_fitossanidade_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class ApontamentoBrocaFormState extends Equatable {
  final List<ApontBrocaModel> brocas;
  final bool carregando;
  final String mensagemErro;
  final List<TipoFitossanidadeModel> tiposFitossanidade;

  ApontamentoBrocaFormState({
    this.brocas = const [],
    this.tiposFitossanidade = const [],
    this.carregando = false,
    this.mensagemErro,
  });

  ApontamentoBrocaFormState juntar({
    bool carregando,
    List<ApontBrocaModel> brocas,
    List<TipoFitossanidadeModel> tiposFitossanidade,
    String mensagemErro,
  }) =>
      ApontamentoBrocaFormState(
        brocas: brocas ?? this.brocas,
        carregando: carregando ?? this.carregando,
        tiposFitossanidade: tiposFitossanidade ?? this.tiposFitossanidade,
        mensagemErro: mensagemErro,
      );

  @override
  List<Object> get props => [brocas, carregando, tiposFitossanidade];
}
