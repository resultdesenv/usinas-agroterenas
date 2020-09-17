import 'package:apontamento/comun/modelo/estimativa_modelo.dart';
import 'package:apontamento/comun/modelo/preferencia_model.dart';
import 'package:apontamento/comun/repositorios/preferencia_repository.dart';
import 'package:apontamento/comun/repositorios/repositorio_estimativa.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_estado.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_eventos.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApontamentoEstimativaListaBloc extends Bloc<
    ApontamentoEstimativaListaEvento, ApontamentoEstimativaListaEstado> {
  final RepositorioEstimativa repositorioEstimativa;
  final PreferenciaRepository preferenciaRepository;

  ApontamentoEstimativaListaBloc({
    @required this.repositorioEstimativa,
    @required this.preferenciaRepository,
  }) : super(ApontamentoEstimativaListaEstado());

  @override
  Stream<ApontamentoEstimativaListaEstado> mapEventToState(
    ApontamentoEstimativaListaEvento evento,
  ) async* {
    if (evento is CarregarListas) {
      try {
        yield state.juntar(
          carregando: true,
          estimativas: [],
          estimativasSelecionadas: [],
        );
        final res = await repositorioEstimativa.get(filtros: evento.filtros);
        final Map<String, List<String>> listaDropDown =
            await repositorioEstimativa.buscaDropDow();

        if (evento.salvaFiltros)
          await preferenciaRepository.salvar(
            preferencia: PreferenciaModel(
              idPreferencia: 'estimativa',
              valorPreferencia: evento.filtros,
            ),
          );

        yield state.juntar(
          carregando: false,
          estimativas: res,
          listaDropDown: listaDropDown,
          filtros: evento.salvaFiltros ? state.filtros : evento.filtros,
        );
      } catch (e) {
        print(e);
        yield state.juntar(carregando: false, mensagemErro: e.toString());
      }
    } else if (evento is MudaSelecaoEstimativa) {
      final List<EstimativaModelo> estimativasSelecionadas =
          List.from(state.estimativasSelecionadas);
      if (estimativasSelecionadas.contains(evento.estimativa)) {
        estimativasSelecionadas.remove(evento.estimativa);
      } else {
        estimativasSelecionadas.add(evento.estimativa);
      }
      yield state.juntar(estimativasSelecionadas: estimativasSelecionadas);
    } else if (evento is RemoverEstimativasSelecionadas) {
      try {
        yield state.juntar(carregando: true);
        await repositorioEstimativa.removerItens(state.estimativasSelecionadas);
        this.add(CarregarListas());
      } catch (e) {
        print(e);
        yield state.juntar(carregando: false, mensagemErro: e.toString());
      }
    } else if (evento is AlterarFiltroEstimativas) {
      final Map<String, String> filtros = Map.from(state.filtros);

      if (evento.valor.isNotEmpty)
        filtros[evento.chave] = evento.valor;
      else
        filtros.remove(evento.chave);

      yield state.juntar(filtros: filtros);
    } else if (evento is IniciarListaEstimativas) {
      final Map<String, String> filtros =
          await preferenciaRepository.get(idPreferencia: 'estimativa');
      this.add(CarregarListas(filtros: filtros, salvaFiltros: false));
    }
  }
}
