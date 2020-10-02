import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UsuarioEmpresaModel extends Equatable {
  final String instancia;
  final String situacao;
  final int idUsuario;
  final int idUsInstancia;

  List<Object> get props => [
    instancia,
    situacao,
    idUsuario,
    idUsInstancia,
  ];

  UsuarioEmpresaModel({
    @required this.instancia,
    @required this.situacao,
    @required this.idUsuario,
    @required this.idUsInstancia,
  });

  factory UsuarioEmpresaModel.fromJson(Map<String, dynamic> json) {
    return UsuarioEmpresaModel(
        instancia: json['instancia'],
        situacao: json['situacao'],
        idUsuario: json['idUsuario'],
        idUsInstancia: json['idUsInstancia']);
  }

  Map<String, dynamic> toJson() => {
    'instancia': instancia,
    'situacao': situacao,
    'idUsuario': idUsuario,
    'idUsInstancia': idUsInstancia,
  };
}
