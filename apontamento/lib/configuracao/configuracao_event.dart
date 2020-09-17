import 'package:meta/meta.dart';

abstract class ConfiguracaoEvent {}

class Iniciar extends ConfiguracaoEvent {}

class AtualizarConfiguracao extends ConfiguracaoEvent {
  final String chave;

  AtualizarConfiguracao({@required this.chave});
}

class EnviarEmail extends ConfiguracaoEvent {}
