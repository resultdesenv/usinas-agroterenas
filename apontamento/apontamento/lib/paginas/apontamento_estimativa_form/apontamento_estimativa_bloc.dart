import 'package:apontamento/comun/repositorios/repositorio_estimativa.dart';
import 'package:apontamento/comun/utilidades/navegacao.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_estado.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_eventos.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_pagina.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class ApontamentoEstimativaBloc
    extends Bloc<ApontamentoEstimativaEvento, ApontamentoEstimativaEstado> {
  final RepositorioEstimativa repositorioEstimativa;

  ApontamentoEstimativaBloc({
    @required this.repositorioEstimativa,
    @required bool criacao,
  }) : super(ApontamentoEstimativaEstado(criacao: criacao));

  @override
  Stream<ApontamentoEstimativaEstado> mapEventToState(
    ApontamentoEstimativaEvento evento,
  ) async* {
    if (evento is AdicionarApontamento) {
      yield state.juntar(apontamentos: [
        ...state.apontamentos,
        ...evento.apontamentos,
      ], mensagemErro: evento.mensagemInicial);
    } else if (evento is EditarApontamento) {
      final apontamentos = state.apontamentos;
      apontamentos[evento.indice] = evento.apontamento;
      yield state.juntar(apontamentos: apontamentos);
    } else if (evento is ApagarApontamentos) {
      try {
        final res = await repositorioEstimativa.removerItens(
          state.apontamentos,
        );

        yield state.juntar(
          loading: false,
          mensagemErro: res ? null : 'Não foi possivel remover as estimativas!',
        );
      } catch (e) {
        print(e);
        yield state.juntar(loading: false, mensagemErro: e.toString());
      }
    } else if (evento is SalvarApontamentos) {
      try {
        print(state.apontamentos);
        yield state.juntar(loading: true);
        final res = state.criacao
            ? await repositorioEstimativa.salvar(state.apontamentos)
            : await repositorioEstimativa.atualizarItens(state.apontamentos);

        yield state.juntar(
          loading: false,
          mensagemErro: res ? null : 'Não foi possivel salvar as estimativas!',
        );

        navegar(
            context: evento.context,
            pagina: ApontamentoEstimativaListaPagina());
      } catch (e) {
        print(e);
        yield state.juntar(loading: false, mensagemErro: e.toString());
      }
    }
  }
}
