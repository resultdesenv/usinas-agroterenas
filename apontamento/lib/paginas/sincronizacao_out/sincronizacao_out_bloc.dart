import 'package:apontamento/comum/modelo/sincronizacao_out_model.dart';
import 'package:apontamento/comum/sincronizacao/sincronizacao_autenticacao.dart';
import 'package:apontamento/paginas/sincronizacao_out/sincronizacao_out_event.dart';
import 'package:apontamento/paginas/sincronizacao_out/sincronizacao_out_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class SincronizacaoOutBloc
    extends Bloc<SincronizacaoOutEvent, SincronizacaoOutState> {
  final SincronizacaoAutenticacao sincronizacaoAutenticacao;

  SincronizacaoOutBloc({
    @required this.sincronizacaoAutenticacao,
  }) : super(SincronizacaoOutState());

  @override
  Stream<SincronizacaoOutState> mapEventToState(
    SincronizacaoOutEvent evento,
  ) async* {
    if (evento is IniciaEstadoSincronizacaoOut) {
      yield state.juntar(carregando: true);
      try {
        final List<SincronizacaoOutModel> sincronizacaoItens = List();

        for (var item in evento.sincronizacaoItens) {
          sincronizacaoItens.add(await item.atualizaInfo());
        }

        yield state.juntar(
          sincronizacaoItens: sincronizacaoItens,
          carregando: false,
        );
      } catch (e) {
        print(e);
        yield state.juntar(mensagemErro: e.toString(), carregando: false);
      }
    }
    if (evento is SincronizarOut) {
      yield state.juntar(carregandoItens: [
        ...state.carregandoItens,
        evento.index,
      ]);

      try {
        final token = await sincronizacaoAutenticacao.index();
        await state.sincronizacaoItens[evento.index].sincronizar(token: token);

        final List<SincronizacaoOutModel> sincronizacaoItens =
            List.from(state.sincronizacaoItens);
        sincronizacaoItens[evento.index] =
            await sincronizacaoItens[evento.index].atualizaInfo();
        yield state.juntar(sincronizacaoItens: sincronizacaoItens);
      } catch (e) {
        print(e);
        yield state.juntar(
          mensagemErro: e.toString(),
        );
      }

      yield state.juntar(
        carregandoItens: state.carregandoItens
            .where((item) => item != evento.index)
            .toList(),
      );
    } else if (evento is SincronizarTudo) {
      List<int> carregandoItens = List.generate(
        state.sincronizacaoItens.length,
        (index) => index,
      );
      yield state.juntar(carregandoItens: carregandoItens);
      final token = await sincronizacaoAutenticacao.index();
      final List<SincronizacaoOutModel> sincronizacaoItens =
          List.from(state.sincronizacaoItens);
      try {
        for (var i = 0; i < state.sincronizacaoItens.length; i++) {
          await state.sincronizacaoItens[i].sincronizar(token: token);
          sincronizacaoItens[i] = await sincronizacaoItens[i].atualizaInfo();
          carregandoItens = carregandoItens.where((item) => item != i).toList();
        }

        yield state.juntar(
          carregandoItens: carregandoItens,
          sincronizacaoItens: sincronizacaoItens,
        );
      } catch (e) {
        print(e);
        yield state.juntar(mensagemErro: e.toString(), carregandoItens: []);
      }
    }
  }
}
