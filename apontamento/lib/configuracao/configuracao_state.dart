import 'package:apontamento/comun/modelo/dispositivo_model.dart';
import 'package:apontamento/comun/modelo/sequencia_model.dart';
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
  final DispositivoModel dispositivo;
  final List<Sequencia> sequencias;

  ConfiguracaoState({
    this.chave,
    this.url,
    this.carregando = false,
    this.salvando = false,
    this.configurado = false,
    this.enviandoEmail = false,
    this.mensagem,
    this.dispositivo,
    this.sequencias = const [],
  });

  List<Object> get props => [
        chave,
        url,
        carregando,
        salvando,
        configurado,
        mensagem,
        enviandoEmail,
        dispositivo,
        sequencias,
      ];

  ConfiguracaoState juntar({
    String chave,
    String url,
    bool carregando,
    bool salvando,
    bool configurado,
    String mensagem,
    bool enviandoEmail,
    DispositivoModel dispositivo,
    List<Sequencia> sequencias,
  }) {
    return ConfiguracaoState(
      chave: chave ?? this.chave,
      url: url ?? this.url,
      carregando: carregando == null ? this.carregando : carregando,
      salvando: salvando == null ? this.salvando : salvando,
      configurado: configurado == null ? this.configurado : configurado,
      enviandoEmail: enviandoEmail == null ? this.enviandoEmail : enviandoEmail,
      mensagem: mensagem,
      dispositivo: dispositivo ?? this.dispositivo,
      sequencias: sequencias ?? this.sequencias,
    );
  }
}
