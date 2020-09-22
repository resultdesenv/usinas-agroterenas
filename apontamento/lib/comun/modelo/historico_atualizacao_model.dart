import 'package:equatable/equatable.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:meta/meta.dart';

class HistoricoAtualizacaoModel extends Equatable {
  final String tabela;
  final DateTime dataAtualizacao;
  final Duration duracao;
  final int quantidade;

  List<Object> get props => [
        tabela,
        dataAtualizacao,
        duracao,
        quantidade,
      ];

  HistoricoAtualizacaoModel({
    @required this.tabela,
    @required this.dataAtualizacao,
    @required this.duracao,
    @required this.quantidade,
  });

  factory HistoricoAtualizacaoModel.fromJson(Map<String, dynamic> json) {
    return HistoricoAtualizacaoModel(
      tabela: json['tabela'],
      dataAtualizacao: DateTime.tryParse(json['dataAtualizacao']),
      duracao: Duration(milliseconds: json['duracao']),
      quantidade: json['quantidade'],
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String toText() {
    timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());
    return this.dataAtualizacao != null
        ? '${timeago.format(this.dataAtualizacao, locale: 'pt_BR')} | ${this.quantidade} | ${_printDuration(this.duracao)}'
        : 'Sem historico de atualização';
  }
}
