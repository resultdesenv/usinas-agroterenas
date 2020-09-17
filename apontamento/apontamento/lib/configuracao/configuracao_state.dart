import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ConfiguracaoState extends Equatable {
  final String chave;
  final String url;
  final bool carregando;
  final bool salvando;
  final bool configurado;
  final String mensagem;
  final bool enviandoEmail;

  ConfiguracaoState({
    this.chave,
    this.url,
    this.carregando = false,
    this.salvando = false,
    this.configurado = false,
    this.enviandoEmail = false,
    this.mensagem,
  });

  List<Object> get props => [
        chave,
        url,
        carregando,
        salvando,
        configurado,
        mensagem,
        enviandoEmail,
      ];

  ConfiguracaoState juntar(
      {String chave,
      String url,
      bool carregando,
      bool salvando,
      bool configurado,
      String mensagem,
      bool enviandoEmail}) {
    return ConfiguracaoState(
      chave: chave ?? this.chave,
      url: url ?? this.url,
      carregando: carregando == null ? this.carregando : carregando,
      salvando: salvando == null ? this.salvando : salvando,
      configurado: configurado == null ? this.configurado : configurado,
      enviandoEmail: enviandoEmail == null ? this.enviandoEmail : enviandoEmail,
      mensagem: mensagem,
    );
  }
}
