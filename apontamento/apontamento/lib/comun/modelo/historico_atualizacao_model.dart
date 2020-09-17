import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class HistoricoAtualizacaoModel extends Equatable {
  final String tabela;
  final DateTime dataAtualizacao;

  List<Object> get props => [
        tabela,
        dataAtualizacao,
      ];

  HistoricoAtualizacaoModel({
    @required this.tabela,
    @required this.dataAtualizacao,
  });

  factory HistoricoAtualizacaoModel.fromJson(Map<String, dynamic> json) =>
      HistoricoAtualizacaoModel(
          tabela: json['tabela'],
          dataAtualizacao: DateTime.tryParse(json['dataAtualizacao']));
}
