import 'package:agronomico/comum/modelo/empresa_model.dart';
import 'package:agronomico/comum/modelo/usuario_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UsuarioSalvo extends Equatable {
  final int idUsuario;
  final String login;
  final String password;
  final int idEmpresa;
  final String cdInstManfro;

  List<Object> get props => [
        idUsuario,
        login,
        password,
        idEmpresa,
        cdInstManfro,
      ];

  UsuarioSalvo({
    @required this.idUsuario,
    @required this.login,
    @required this.password,
    @required this.idEmpresa,
    @required this.cdInstManfro,
  });

  factory UsuarioSalvo.fromJson(Map<String, dynamic> json) {
    return UsuarioSalvo(
      idUsuario: int.tryParse(json['idUsuario'].toString()),
      login: json['login'],
      password: json['password'],
      idEmpresa: int.tryParse(json['idEmpresa'].toString()),
      cdInstManfro: json['cdInstManfro'],
    );
  }

  factory UsuarioSalvo.fromUsuario(Usuario usuario, EmpresaModel empresa) {
    return UsuarioSalvo(
      idUsuario: usuario.idUsuario,
      login: usuario.login,
      password: usuario.password,
      idEmpresa: empresa.cdEmpresa,
      cdInstManfro: empresa.cdInstManfro,
    );
  }

  Map<String, dynamic> toJson() => {
        'idUsuario': idUsuario,
        'login': login,
        'password': password,
        'idEmpresa': idEmpresa,
        'cdInstManfro': cdInstManfro,
      };

  UsuarioSalvo copyWith({
    int idUsuario,
    String login,
    String password,
    int idEmpresa,
    String cdInstManfro,
  }) =>
      UsuarioSalvo(
        idUsuario: idUsuario ?? this.idUsuario,
        login: login ?? this.login,
        password: password ?? this.password,
        idEmpresa: idEmpresa ?? this.idEmpresa,
        cdInstManfro: cdInstManfro ?? this.cdInstManfro,
      );
}
