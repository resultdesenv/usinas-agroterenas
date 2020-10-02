import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comum/repositorios/repositorio_estimativa.dart';
import 'package:apontamento/comum/repositorios/sequencia_repository.dart';
import 'package:apontamento/comum/utilidades/navegacao.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_state.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_event.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_page.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class ApontamentoEstimativaBloc
    extends Bloc<ApontamentoEstimativaEvento, ApontamentoEstimativaState> {
  final RepositorioEstimativa repositorioEstimativa;
  final SincronizacaoSequenciaRepository sequenciaRepository;

  ApontamentoEstimativaBloc({
    @required this.repositorioEstimativa,
    @required this.sequenciaRepository,
    @required bool criacao,
  }) : super(ApontamentoEstimativaState(criacao: criacao));

  @override
  Stream<ApontamentoEstimativaState> mapEventToState(
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

        if (res)
          navegar(
              context: evento.context,
              pagina: ApontamentoEstimativaListaPage());
      } catch (e) {
        print(e);
        yield state.juntar(loading: false, mensagemErro: e.toString());
      }
    } else if (evento is SalvarApontamentos) {
      try {
        yield state.juntar(loading: true);
        print(state.apontamentos[0].props);
        final res = state.criacao
            ? await repositorioEstimativa.salvar(state.apontamentos)
            : await repositorioEstimativa.atualizarItens(state.apontamentos);

        yield state.juntar(
          loading: false,
          mensagemErro: res ? null : 'Não foi possivel salvar as estimativas!',
        );

        if (state.criacao) {
          final empresa = BaseInherited.of(
            evento.context,
          ).empresaAutenticada;

          final sequencia =
              await sequenciaRepository.buscarSequencia(empresa: empresa);
          final res = await sequenciaRepository.salvarSequencia(
            sequencia: sequencia.juntar(sequencia: sequencia.sequencia + 1),
          );
          print(res.toJson());
        }
        navegar(
            context: evento.context, pagina: ApontamentoEstimativaListaPage());
      } catch (e) {
        print(e);
        yield state.juntar(loading: false, mensagemErro: e.toString());
      }
    }
  }
}
