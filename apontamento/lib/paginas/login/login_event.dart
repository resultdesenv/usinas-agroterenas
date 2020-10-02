import 'package:meta/meta.dart';

abstract class LoginEvent {}

class BuscarEmpresas extends LoginEvent {
  final String usuario;

  BuscarEmpresas({@required this.usuario});
}

class Started extends LoginEvent {}

class Logar extends LoginEvent {
  final String usuario;
  final String senha;
  final String cmEmpresa;
  final bool salvar;

  Logar(
      {@required this.usuario,
      @required this.senha,
      @required this.cmEmpresa,
      @required this.salvar});
}

class AtualizarLembrar extends LoginEvent {
  final bool lembrar;

  AtualizarLembrar({@required this.lembrar});
}
