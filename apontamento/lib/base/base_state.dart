import 'package:apontamento/comum/modelo/empresa_model.dart';
import 'package:apontamento/comum/modelo/usuario_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class BaseState extends Equatable {
  final String chave;
  final String url;
  final bool pronto;
  final EmpresaModel empresaAutenticada;
  final Usuario usuarioAutenticada;

  BaseState({
    this.chave,
    this.url,
    this.pronto = false,
    this.empresaAutenticada,
    this.usuarioAutenticada,
  });

  List<Object> get props =>
      [chave, url, pronto, empresaAutenticada, usuarioAutenticada];

  BaseState juntar({
    String chave,
    String url,
    bool pronto,
    EmpresaModel empresaAutenticada,
    Usuario usuarioAutenticada,
  }) {
    return BaseState(
      chave: chave ?? this.chave,
      url: url ?? this.url,
      pronto: pronto == null ? this.pronto : pronto,
      empresaAutenticada: empresaAutenticada ?? this.empresaAutenticada,
      usuarioAutenticada: usuarioAutenticada ?? this.usuarioAutenticada,
    );
  }
}
