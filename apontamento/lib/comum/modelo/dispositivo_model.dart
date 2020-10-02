import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class DispositivoModel extends Equatable {
  final int idDispositivo;
  final String imei;
  final String situacao;

  List<Object> get props => [idDispositivo, imei, situacao];

  DispositivoModel(
      {@required this.idDispositivo,
      @required this.imei,
      @required this.situacao});

  factory DispositivoModel.fromJson(Map<String, dynamic> json) => DispositivoModel(
      idDispositivo: int.tryParse(json['idDispositivo'].toString()),
      imei: json['imei'].toString(),
      situacao: json['situacao'].toString());

  Map<String, dynamic> toJson() =>
      {'idDispositivo': idDispositivo, 'imei': imei, 'situacao': situacao};
}
