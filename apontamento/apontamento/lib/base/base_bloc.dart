import 'package:apontamento/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_event.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc() : super(BaseState());

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is IniciarBase) {
      final prefs = await SharedPreferences.getInstance();
      String chave = prefs.getString('chave');
      String url = prefs.getString('url');
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
