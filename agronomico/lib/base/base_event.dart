import 'package:agronomico/comum/modelo/empresa_model.dart';
import 'package:agronomico/comum/modelo/usuario_model.dart';
import 'package:meta/meta.dart';

abstract class BaseEvent {}

class IniciarBase extends BaseEvent {}

class AtualizarBase extends BaseEvent {
  final String chave;
  final String url;

  AtualizarBase({@required this.chave, @required this.url});
}

class InserirInformacoesUsuario extends BaseEvent {
  final Usuario usuario;
  final EmpresaModel empresaModel;

  InserirInformacoesUsuario(
      {@required this.usuario, @required this.empresaModel});
}
