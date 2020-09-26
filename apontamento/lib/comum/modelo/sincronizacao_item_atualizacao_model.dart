import 'package:apontamento/comum/sincronizacao/sincronizacao_base.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// TODO: Usar um nome mais claro
class HistoricoItemAtualizacaoModel extends Equatable {
  final String nome;
  final String tabela;
  final SincronizacaoBase repository;
  final String atualizacao;
  final bool atualizando;
  final bool upnivel3;

  List<Object> get props => [
        nome,
        tabela,
        atualizacao,
        atualizando,
        upnivel3,
      ];

  HistoricoItemAtualizacaoModel({
    @required this.nome,
    @required this.tabela,
    @required this.repository,
    this.atualizacao,
    this.atualizando = false,
    this.upnivel3 = false,
  });

  HistoricoItemAtualizacaoModel copyWith({
    String nome,
    String tabela,
    SincronizacaoBase repository,
    String atualizacao,
    bool atualizando,
    bool upnivel3,
  }) =>
      HistoricoItemAtualizacaoModel(
        nome: nome ?? this.nome,
        tabela: tabela ?? this.tabela,
        repository: repository ?? this.repository,
        atualizacao: atualizacao ?? this.atualizacao,
        atualizando: atualizando == null ? this.atualizando : atualizando,
        upnivel3: upnivel3 == null ? this.upnivel3 : upnivel3,
      );
}
