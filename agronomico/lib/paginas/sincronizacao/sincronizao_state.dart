import 'package:agronomico/comum/modelo/safra_model.dart';
import 'package:agronomico/comum/modelo/sincronizacao_item_atualizacao_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class SincronizacaoState extends Equatable {
  final String mensagem;
  final bool carregando;
  final List<HistoricoItemAtualizacaoModel> itensSincronizacao;
  final List<SafraModel> safras;
  final SafraModel safraSelecionada;
  final String filtroNivel2;

  SincronizacaoState({
    this.carregando = false,
    this.itensSincronizacao = const [],
    this.safras = const [],
    this.safraSelecionada,
    this.mensagem,
    this.filtroNivel2,
  });

  List<Object> get props => [
        mensagem,
        carregando,
        itensSincronizacao,
        safraSelecionada,
        filtroNivel2,
      ];

  SincronizacaoState copyWith({
    String mensagem,
    bool carregando,
    List<HistoricoItemAtualizacaoModel> itensSincronizacao,
    List<SafraModel> safras,
    SafraModel safraSelecionada,
    String filtroNivel2,
  }) =>
      SincronizacaoState(
          mensagem: mensagem,
          carregando: carregando == null ? this.carregando : carregando,
          itensSincronizacao: itensSincronizacao ?? this.itensSincronizacao,
          safras: safras ?? this.safras,
          safraSelecionada: safraSelecionada ?? this.safraSelecionada,
          filtroNivel2: filtroNivel2 ?? this.filtroNivel2);
}
