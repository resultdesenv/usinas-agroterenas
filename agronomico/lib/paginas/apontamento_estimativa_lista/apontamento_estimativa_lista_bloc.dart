import 'dart:convert';

import 'package:agronomico/comum/modelo/estimativa_modelo.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:agronomico/comum/repositorios/repositorio_estimativa.dart';
import 'package:agronomico/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_state.dart';
import 'package:agronomico/paginas/apontamento_estimativa_lista/apontamento_estimativa_lista_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApontamentoEstimativaListaBloc extends Bloc<
    ApontamentoEstimativaListaEvent, ApontamentoEstimativaListaState> {
  final RepositorioEstimativa repositorioEstimativa;
  final PreferenciaRepository preferenciaRepository;

  ApontamentoEstimativaListaBloc({
    @required this.repositorioEstimativa,
    @required this.preferenciaRepository,
  }) : super(ApontamentoEstimativaListaState());

  @override
  Stream<ApontamentoEstimativaListaState> mapEventToState(
    ApontamentoEstimativaListaEvent evento,
  ) async* {
    if (evento is CarregarListas) {
      try {
        yield state.juntar(
          carregando: true,
          estimativas: [],
          estimativasSelecionadas: [],
        );

        final res = await repositorioEstimativa.get(
          filtros: _formataFiltros(evento.filtros),
        );
        final Map<String, List<String>> listaDropDown =
            await repositorioEstimativa.buscaDropDow();

        if (evento.salvaFiltros)
          await preferenciaRepository.salvar(
            idPreferencia: 'estimativaLista',
            valorPreferencia: json.encode(evento.filtros),
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
      final Map<String, dynamic> filtros = Map.from(state.filtros);

      if (evento.valor.isNotEmpty)
        filtros[evento.chave] = evento.valor;
      else
        filtros.remove(evento.chave);

      yield state.juntar(filtros: filtros);
    } else if (evento is IniciarListaEstimativas) {
      final res =
          await preferenciaRepository.get(idPreferencia: 'estimativaLista');
      final Map<String, dynamic> filtros = res != null ? json.decode(res) : {};
      final up2 = await repositorioEstimativa.buscaUp2();
      final listaDropDown = {
        'cdUpnivel2': up2,
      };

      filtros.keys.forEach((chave) {
        if (filtros[chave] != null && filtros[chave].toString().isNotEmpty) {
          listaDropDown[chave] = [filtros[chave]];
        }
      });

      yield state.juntar(
        filtros: filtros,
        listaDropDown: listaDropDown,
      );
    } else if (evento is BuscaSafra) {
      final listaDropDown = state.listaDropDown;
      final filtros = state.filtros;
      final safra = await repositorioEstimativa.buscaSafra(
        up1: evento.up1,
        up2: state.filtros['cdUpnivel2'],
      );
      listaDropDown['cdSafra'] = safra;

      yield state.juntar(listaDropDown: listaDropDown, filtros: {
        ...filtros,
        'cdUpnivel1': evento.up1,
        'cdSafra': '',
        'cdUpnivel3': '',
      });
    } else if (evento is BuscaUpnivel1) {
      final listaDropDown = state.listaDropDown;
      final filtros = state.filtros;
      final up1 = await repositorioEstimativa.buscaUp1(up2: evento.up2);

      listaDropDown['cdUpnivel1'] = up1;

      yield state.juntar(listaDropDown: listaDropDown, filtros: {
        ...filtros,
        'cdUpnivel2': evento.up2,
        'cdUpnivel1': '',
        'cdSafra': '',
        'cdUpnivel3': '',
      });
    } else if (evento is BuscaUpnivel3) {
      final listaDropDown = state.listaDropDown;
      final filtros = state.filtros;
      final up3 = await repositorioEstimativa.buscaUp3(
        safra: evento.safra,
        up1: state.filtros['cdUpnivel1'],
        up2: state.filtros['cdUpnivel2'],
      );
      listaDropDown['cdUpnivel3'] = up3;

      yield state.juntar(listaDropDown: listaDropDown, filtros: {
        ...filtros,
        'cdSafra': evento.safra,
        'cdUpnivel3': '',
      });
    } else if (evento is CheckAllEstimativaLista) {
      if (!evento.valor) {
        yield state.juntar(estimativasSelecionadas: []);
      } else {
        yield state.juntar(estimativasSelecionadas: state.estimativas);
      }
    }
  }

  Map<String, dynamic> _formataFiltros(Map<String, dynamic> valores) {
    final Map<String, dynamic> filtrosFormatados = Map.from(valores);
    filtrosFormatados.removeWhere((chave, valor) => valor.isEmpty);

    if (valores['dtInicio'] != null && valores['dtFim'] != null) {
      final dataInicio = ">= date('${valores['dtInicio']}') ";
      final dataFinal = "<= date('${valores['dtFim']}')";

      filtrosFormatados['date(dtHistorico)'] =
          "${valores['dtInicio'] != null ? dataInicio : " "}"
          "${valores['dtInicio'] != null && valores['dtFim'] != null ? " AND date(dtUltimoCorte) " : ""} "
          "${valores['dtFim'] != null ? dataFinal : ""}";
    }

    filtrosFormatados.remove('dtInicio');
    filtrosFormatados.remove('dtFim');

    if (valores['status'] != null && valores['status'].isNotEmpty)
      filtrosFormatados['status'] = 'IN ${valores['status']}';

    return filtrosFormatados;
  }
}
