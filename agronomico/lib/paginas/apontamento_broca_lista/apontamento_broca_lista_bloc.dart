import 'dart:convert';
import 'package:agronomico/comum/repositorios/apont_broca_consulta_repository.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_event.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class ApontamentoBrocaListaBloc
    extends Bloc<ApontamentoBrocaListaEvent, ApontamentoBrocaListaState> {
  final ApontBrocaConsultaRepository repositorioBroca;
  final PreferenciaRepository preferenciaRepository;

  ApontamentoBrocaListaBloc({
    @required this.repositorioBroca,
    @required this.preferenciaRepository,
  }) : super(ApontamentoBrocaListaState());

  @override
  Stream<ApontamentoBrocaListaState> mapEventToState(
    ApontamentoBrocaListaEvent event,
  ) async* {
    if (event is IniciaBrocaLista) {
      final res = await preferenciaRepository.get(idPreferencia: 'broca_lista');
      final Map<String, dynamic> filtros = res != null ? json.decode(res) : {};
      final up2 = await repositorioBroca.buscaUp2();
      final listaDropDown = {
        'cdUpnivel2': up2,
      };

      filtros.remove('dtInicio');
      filtros.remove('dtFim');

      yield state.juntar(
        filtros: filtros,
        listaDropDown: listaDropDown,
      );
    }

    if (event is BuscaListaBroca) {
      yield state.juntar(carregando: true, apagaSelecao: true);
      try {
        if (event.salvaFiltros) {
          await preferenciaRepository.salvar(
            idPreferencia: 'broca_lista',
            valorPreferencia: json.encode(event.filtros),
          );
        }

        final brocas = await repositorioBroca.resumos(
          filtros: _formataFiltros(event.filtros),
        );

        yield state.juntar(
          filtros: event.filtros,
          carregando: false,
          brocas: brocas,
        );
      } catch (e) {
        print(e);
        yield state.juntar(mensagemErro: e.toString(), carregando: false);
      }
    }

    if (event is AlterarFiltroBroca) {
      final Map<String, dynamic> filtros = Map.from(state.filtros);

      if (event.valor.isNotEmpty)
        filtros[event.chave] = event.valor;
      else
        filtros.remove(event.chave);

      yield state.juntar(filtros: filtros);
    }

    if (event is AlteraSelecaoBroca) {
      yield state.juntar(
        brocaSelecionada: event.broca,
        apagaSelecao: !event.value,
      );
    }

    if (event is RemoverBrocas) {
      yield state.juntar(carregando: true);
      try {
        await repositorioBroca
            .removerPorBoletim(state.brocaSelecionada.noBoletim);
        final brocas = await repositorioBroca.resumos(
          filtros: _formataFiltros(state.filtros),
        );

        yield state.juntar(
          carregando: false,
          brocas: brocas,
          apagaSelecao: true,
        );
      } catch (e) {
        print(e);
        yield state.juntar(mensagemErro: e.toString(), carregando: false);
      }
    }
  }

  Map<String, dynamic> _formataFiltros(Map<String, dynamic> valores) {
    final Map<String, dynamic> filtrosFormatados = Map.from(valores);
    filtrosFormatados.removeWhere((chave, valor) => valor.isEmpty);

    if (valores['dtInicio'] != null && valores['dtFim'] != null) {
      final dataInicio = ">= date('${valores['dtInicio']}') ";
      final dataFinal = "<= date('${valores['dtFim']}')";

      filtrosFormatados['date(dtOperacao)'] =
          "${valores['dtInicio'] != null ? dataInicio : " "}"
          "${valores['dtInicio'] != null && valores['dtFim'] != null ? " AND date(dtOperacao) " : ""} "
          "${valores['dtFim'] != null ? dataFinal : ""}";
    }

    filtrosFormatados.remove('dtInicio');
    filtrosFormatados.remove('dtFim');

    if (valores['status'] != null && valores['status'].isNotEmpty)
      filtrosFormatados['status'] = 'IN ${valores['status']}';

    return filtrosFormatados;
  }
}
