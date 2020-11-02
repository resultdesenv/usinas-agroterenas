import 'package:meta/meta.dart';

class Sequencia {
  final String aplicacao;
  final String idDispositivo;
  final String instancia;
  final int sequencia;
  final int idAplicacao;

  Sequencia({
    @required this.aplicacao,
    @required this.idDispositivo,
    @required this.instancia,
    @required this.sequencia,
    @required this.idAplicacao,
  });

  factory Sequencia.fromJson(Map<String, dynamic> json) {
    return Sequencia(
      aplicacao: json['aplicacao'],
      idDispositivo: json['idDispositivo'].toString(),
      instancia: json['instancia'],
      sequencia: int.tryParse(json['sequencia']?.toString()),
      idAplicacao: int.tryParse(json['idAplicacao']?.toString()),
    );
  }

  Sequencia juntar({
    String aplicacao,
    String idDispositivo,
    String instancia,
    int sequencia,
    int idAplicacao,
  }) {
    return Sequencia(
      aplicacao: aplicacao ?? this.aplicacao,
      idDispositivo: idDispositivo ?? this.idDispositivo,
      instancia: instancia ?? this.instancia,
      sequencia: sequencia ?? this.sequencia,
      idAplicacao: idAplicacao ?? this.idAplicacao,
    );
  }

  Map<String, dynamic> toJson() => {
        'aplicacao': aplicacao,
        'idDispositivo': idDispositivo,
        'instancia': instancia,
        'sequencia': sequencia,
        'idAplicacao': idAplicacao
      };
}
