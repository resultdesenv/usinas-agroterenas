import 'package:apontamento/comum/modelo/empresa_model.dart';
import 'package:apontamento/comum/modelo/usuario_model.dart';
import 'package:apontamento/comum/modelo/usuario_salvo_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class LoginState extends Equatable {
  final String versao;
  final String mensagem;
  final bool carregando;
  final bool pronto;
  final bool lembrar;
  final bool autenticado;
  final bool buscandoEmpresas;
  final List<EmpresaModel> empresas;
  final EmpresaModel empresaAutenticada;
  final Usuario usuarioAutenticada;
  final List<UsuarioSalvo> usuariosSalvos;
  final bool irParaConfiguracao;

  LoginState({
    this.versao,
    this.mensagem,
    this.lembrar = false,
    this.carregando = false,
    this.pronto = false,
    this.autenticado = false,
    this.buscandoEmpresas = false,
    this.empresas = const [],
    this.empresaAutenticada,
    this.usuarioAutenticada,
    this.usuariosSalvos = const [],
    this.irParaConfiguracao = false,
  });

  LoginState juntar({
    String versao,
    String mensagem,
    bool lembrar,
    bool carregando,
    bool pronto,
    bool autenticado,
    bool buscandoEmpresas,
    List<EmpresaModel> empresas,
    EmpresaModel empresaAutenticada,
    Usuario usuarioAutenticada,
    List<UsuarioSalvo> usuariosSalvos,
    bool irParaConfiguracao,
  }) {
    return LoginState(
      versao: versao ?? this.versao,
      mensagem: mensagem,
      carregando: carregando == null ? this.carregando : carregando,
      lembrar: lembrar == null ? this.lembrar : lembrar,
      pronto: pronto == null ? this.pronto : pronto,
      autenticado: autenticado == null ? this.autenticado : autenticado,
      buscandoEmpresas:
          buscandoEmpresas == null ? this.buscandoEmpresas : buscandoEmpresas,
      empresas: empresas ?? this.empresas,
      empresaAutenticada: empresaAutenticada ?? this.empresaAutenticada,
      usuarioAutenticada: usuarioAutenticada ?? this.usuarioAutenticada,
      usuariosSalvos: usuariosSalvos ?? this.usuariosSalvos,
      irParaConfiguracao: irParaConfiguracao == null
          ? this.irParaConfiguracao
          : irParaConfiguracao,
    );
  }

  @override
  List<Object> get props => [
        versao,
        mensagem,
        carregando,
        lembrar,
        pronto,
        autenticado,
        buscandoEmpresas,
        empresas,
        empresaAutenticada,
        usuarioAutenticada,
        usuariosSalvos,
        irParaConfiguracao,
      ];
}
