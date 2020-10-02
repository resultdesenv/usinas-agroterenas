import 'package:apontamento/comum/modelo/safra_model.dart';
import 'package:apontamento/comum/modelo/sincronizacao_item_atualizacao_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class SincronizacaoState extends Equatable {
  final String mensagem;
  final bool carregando;
  final List<HistoricoItemAtualizacaoModel> itensSincronizacao;
  final List<SafraModel> safras;
  final SafraModel safraSelecionada;

  SincronizacaoState(
      {this.carregando = false,
      this.itensSincronizacao = const [],
      this.safras = const [],
      this.safraSelecionada,
      this.mensagem});

  List<Object> get props =>
      [mensagem, carregando, itensSincronizacao, safraSelecionada];

  SincronizacaoState copyWith({
    String mensagem,
    bool carregando,
    List<HistoricoItemAtualizacaoModel> itensSincronizacao,
    List<SafraModel> safras,
    SafraModel safraSelecionada,
  }) =>
      SincronizacaoState(
        mensagem: mensagem,
        carregando: carregando == null ? this.carregando : carregando,
        itensSincronizacao: itensSincronizacao ?? this.itensSincronizacao,
        safras: safras ?? this.safras,
        safraSelecionada: safraSelecionada ?? this.safraSelecionada,
      );
}
