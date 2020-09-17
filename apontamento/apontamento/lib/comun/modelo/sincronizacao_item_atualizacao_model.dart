import 'package:apontamento/comun/sincronizacao/sincronizacao_base.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// TODO: Usar um nome mais claro
class HistoricoItemAtualizacaoModel extends Equatable {
  final String nome;
  final String tabela;
  final SincronizacaoBase repository;
  final DateTime dataAtualizacao;
  final bool atualizando;
  final bool upnivel3;

  List<Object> get props => [
        nome,
        tabela,
        dataAtualizacao,
        atualizando,
        upnivel3,
      ];

  HistoricoItemAtualizacaoModel({
    @required this.nome,
    @required this.tabela,
    @required this.repository,
    this.dataAtualizacao,
    this.atualizando = false,
    this.upnivel3 = false,
  });

  HistoricoItemAtualizacaoModel copyWith({
    String nome,
    String tabela,
    SincronizacaoBase repository,
    DateTime dataAtualizacao,
    bool atualizando,
    bool upnivel3,
  }) =>
      HistoricoItemAtualizacaoModel(
        nome: nome ?? this.nome,
        tabela: tabela ?? this.tabela,
        repository: repository ?? this.repository,
        dataAtualizacao: dataAtualizacao ?? this.dataAtualizacao,
        atualizando: atualizando == null ? this.atualizando : atualizando,
        upnivel3: upnivel3 == null ? this.upnivel3 : upnivel3,
      );
}
