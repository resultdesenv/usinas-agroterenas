import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Usuario extends Equatable {
  final int idUsuario;
  final int cdFunc;
  final String deFunc;
  final String mobile;
  final String portalweb;
  final String nivel;
  final String situacao;
  final String login;
  final String password;

  List<Object> get props => [
        idUsuario,
        cdFunc,
        deFunc,
        mobile,
        portalweb,
        nivel,
        situacao,
        login,
        password,
      ];

  Usuario({
    @required this.idUsuario,
    @required this.cdFunc,
    @required this.deFunc,
    @required this.mobile,
    @required this.portalweb,
    @required this.nivel,
    @required this.situacao,
    @required this.login,
    @required this.password,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idUsuario: int.tryParse(json['idUsuario'].toString()),
      cdFunc: int.tryParse(json['cdFunc'].toString()),
      deFunc: json['deFunc'],
      mobile: json['mobile'],
      portalweb: json['portalweb'],
      nivel: json['nivel'],
      situacao: json['situacao'],
      login: json['login'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'idUsuario': idUsuario,
        'cdFunc': cdFunc,
        'deFunc': deFunc,
        'mobile': mobile,
        'portalweb': portalweb,
        'nivel': nivel,
        'situacao': situacao,
        'login': login,
        'password': password,
      };

  Usuario copyWith({
    int idUsuario,
    int cdFunc,
    String deFunc,
    String mobile,
    String portalweb,
    String nivel,
    String situacao,
    String login,
    String password,
  }) =>
      Usuario(
        idUsuario: idUsuario ?? this.idUsuario,
        cdFunc: cdFunc ?? this.cdFunc,
        deFunc: deFunc ?? this.deFunc,
        mobile: mobile ?? this.mobile,
        portalweb: portalweb ?? this.portalweb,
        nivel: nivel ?? this.nivel,
        situacao: situacao ?? this.situacao,
        login: login ?? this.login,
        password: password ?? this.password,
      );
}
