import 'dart:convert';
import 'package:agronomico/comum/modelo/apont_broca_model.dart';
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
      ApontamentoBrocaListaEvent event) async* {
    if (event is BuscaListaBroca) {
      if (event.salvaFiltros) {
        await preferenciaRepository.salvar(
          idPreferencia: 'estimativaLista',
          valorPreferencia: json.encode(event.filtros),
        );
      }
      yield state.juntar(filtros: event.filtros);
    }

    if (event is AlterarFiltroBroca) {
      final Map<String, dynamic> filtros = Map.from(state.filtros);

      if (event.valor.isNotEmpty)
        filtros[event.chave] = event.valor;
      else
        filtros.remove(event.chave);

      yield state.juntar(filtros: filtros);
    }

    if (event is BuscaSafra) {
      final listaDropDown = state.listaDropDown;
      final filtros = state.filtros;
      final safra = await repositorioBroca.buscaSafra(
        up1: event.up1,
      );
      listaDropDown['cdSafra'] = safra;
      yield state.juntar(listaDropDown: listaDropDown, filtros: {
        ...filtros,
        'cdUpnivel1': event.up1,
        'cdSafra': '',
        'cdUpnivel2': '',
        'cdUpnivel3': '',
      });
    }

    if (event is BuscaUpnivel2) {
      final listaDropDown = state.listaDropDown;
      final filtros = state.filtros;
      final up2 = await repositorioBroca.buscaUp2(
        safra: event.safra,
      );

      listaDropDown['cdUpnivel2'] = up2;

      yield state.juntar(listaDropDown: listaDropDown, filtros: {
        ...filtros,
        'cdSafra': event.safra,
        'cdUpnivel2': '',
        'cdUpnivel3': '',
      });
    }

    if (event is BuscaUpnivel3) {
      final listaDropDown = state.listaDropDown;
      final filtros = state.filtros;
      final up3 = await repositorioBroca.buscaUp3(
        up2: event.up2,
      );
      listaDropDown['cdUpnivel3'] = up3;

      yield state.juntar(listaDropDown: listaDropDown, filtros: {
        ...filtros,
        'cdUpnivel2': event.up2,
        'cdUpnivel3': '',
      });
    }

    if (event is MontaBoletimBroca) {
      try {
        int noSeqAtual = 0;
        final List<ApontBrocaModel> apontBrocas = List(100)
            .map((_) => ApontBrocaModel.fromUpnivel3(
                  event.upniveis.first,
                  noBoletin: event.noBoletim,
                  noSequencia: ++noSeqAtual,
                  dispositivo: event.dispositivo,
                  cdFunc: event.cdFunc,
                ))
            .toList();
        await repositorioBroca.salvar(apontBrocas);
        // navegar(
        //   context: event.context,
        //   pagina: ApontamentoBrocaForm(brocas: apontBrocas),
        // );
      } catch (e) {
        print(e);
        yield state.juntar(mensagemErro: e.toString());
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
