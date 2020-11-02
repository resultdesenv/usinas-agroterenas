import 'package:agronomico/base/base_state.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'base_event.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  final PreferenciaRepository preferenciaRepository;

  BaseBloc({@required this.preferenciaRepository}) : super(BaseState());

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is IniciarBase) {
      String chave = await preferenciaRepository.get(idPreferencia: 'chave');
      String url = await preferenciaRepository.get(idPreferencia: 'url');

      yield BaseState(chave: chave, url: url, pronto: true);
    }
    if (event is AtualizarBase) {
      yield BaseState(
        chave: event.chave,
        url: event.url,
        pronto: true,
      );
    }

    if (event is InserirInformacoesUsuario) {
      yield BaseState(
        chave: state.chave,
        url: state.url,
        pronto: state.pronto,
        usuarioAutenticada: event.usuario,
        empresaAutenticada: event.empresaModel,
      );
    }
  }
}
