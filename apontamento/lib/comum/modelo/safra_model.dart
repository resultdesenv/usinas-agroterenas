import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SafraModel extends Equatable {
  final int cdSafra;
  final String dtFimSafra;
  final String dtFinalColheita;
  final String dtIniSafra;
  final String dtInicioColheita;
  final String instancia;

  List<Object> get props => [
        cdSafra,
        dtFimSafra,
        dtFinalColheita,
        dtIniSafra,
        dtInicioColheita,
        instancia
      ];

  SafraModel({
    @required this.cdSafra,
    @required this.dtFimSafra,
    @required this.dtFinalColheita,
    @required this.dtIniSafra,
    @required this.dtInicioColheita,
    @required this.instancia,
  });

  factory SafraModel.fromJson(Map<String, dynamic> json) => SafraModel(
        cdSafra: json['cdSafra'],
        dtFimSafra: json['dtFimSafra'].toString(),
        dtFinalColheita: json['dtFinalColheita'].toString(),
        dtIniSafra: json['dtIniSafra'].toString(),
        dtInicioColheita: json['dtInicioColheita'].toString(),
        instancia: json['instancia'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'cdSafra': cdSafra,
        'dtFimSafra': dtFimSafra,
        'dtFinalColheita': dtFinalColheita,
        'dtIniSafra': dtIniSafra,
        'dtInicioColheita': dtInicioColheita,
        'instancia': instancia,
      };
}
