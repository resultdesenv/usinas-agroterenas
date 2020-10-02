import 'package:apontamento/comum/modelo/sincronizacao_out_model.dart';
import 'package:equatable/equatable.dart';

class SincronizacaoOutState extends Equatable {
  final List<SincronizacaoOutModel> sincronizacaoItens;
  final bool carregando;
  final String mensagemErro;
  final List<int> carregandoItens;

  SincronizacaoOutState({
    this.sincronizacaoItens = const [],
    this.carregando = false,
    this.mensagemErro,
    this.carregandoItens = const [],
  });

  SincronizacaoOutState juntar({
    List<SincronizacaoOutModel> sincronizacaoItens,
    bool carregando,
    String mensagemErro,
    List<int> carregandoItens,
  }) {
    return SincronizacaoOutState(
      sincronizacaoItens: sincronizacaoItens ?? this.sincronizacaoItens,
      carregando: carregando ?? this.carregando,
      carregandoItens: carregandoItens ?? this.carregandoItens,
      mensagemErro: mensagemErro,
    );
  }

  @override
  List<Object> get props => [
        sincronizacaoItens,
        carregando,
        mensagemErro,
        carregandoItens,
      ];
}
