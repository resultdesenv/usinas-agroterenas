import 'dart:convert';

import 'package:agronomico/base/base_inherited.dart';
import 'package:agronomico/comum/modelo/estimativa_modelo.dart';
import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:agronomico/comum/repositorios/upnivel3_consulta_repository.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:agronomico/comum/repositorios/repositorio_estimativa.dart';
import 'package:agronomico/comum/repositorios/sequencia_repository.dart';
import 'package:agronomico/comum/utilidades/navegacao.dart';
import 'package:agronomico/paginas/apontamento_estimativa_form/apontamento_estimativa_page.dart';
import 'package:agronomico/paginas/upnivel3/upnivel3_event.dart';
import 'package:agronomico/paginas/upnivel3/upnivel3_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class UpNivel3Bloc extends Bloc<UpNivel3Event, UpNivel3State> {
  final UpNivel3ConsultaRepository upNivel3ConsultaRepository;
  final PreferenciaRepository preferenciaRepository;
  final RepositorioEstimativa estimativaRepository;
  final SincronizacaoSequenciaRepository sequenciaRepository;

  UpNivel3Bloc({
    @required this.upNivel3ConsultaRepository,
    @required this.preferenciaRepository,
    @required this.estimativaRepository,
    @required this.sequenciaRepository,
  }) : super(UpNivel3State());

  @override
  Stream<UpNivel3State> mapEventToState(UpNivel3Event evento) async* {
    if (evento is AlterarFiltroUpNivel3) {
      final Map<String, dynamic> filtros = Map.from(state.filtros);

      if (evento.valor.isNotEmpty)
        filtros[evento.chave] = evento.valor;
      else
        filtros.remove(evento.chave);

      yield state.juntar(filtros: filtros);
    } else if (evento is BuscaListaUpNivel3) {
      try {
        yield state.juntar(
          carregando: true,
          lista: [],
          selecionadas: [],
        );

        final res = await upNivel3ConsultaRepository.get(
          filtros: _formataFiltros(evento.filtros),
        );

        if (evento.salvaFiltros)
          await preferenciaRepository.salvar(
            idPreferencia: 'upnivel3Filtros',
            valorPreferencia: json.encode(evento.filtros),
          );

        yield state.juntar(
          carregando: false,
          lista: res,
          filtros: evento.salvaFiltros ? state.filtros : evento.filtros,
        );
      } catch (e) {
        print(e);
        yield state.juntar(carregando: false, mensagemErro: e.toString());
      }
    } else if (evento is MudaSelecaoUpNivel3) {
      final List<UpNivel3Model> selecionadas = List.from(state.selecionadas);
      if (selecionadas.contains(evento.upnivel3)) {
        selecionadas.remove(evento.upnivel3);
      } else {
        selecionadas.add(evento.upnivel3);
      }
      yield state.juntar(selecionadas: selecionadas);
    } else if (evento is IniciarListaUpNivel3) {
      final Map<String, dynamic> filtros = json.decode(
          await preferenciaRepository.get(idPreferencia: 'upnivel3Filtros') ??
              '{}');
      final up1 = await upNivel3ConsultaRepository.buscaUp1();

      yield state.juntar(
        filtros: filtros,
        listaDropDown: {'cdUpnivel1': up1},
      );
    } else if (evento is BuscaSafra) {
      final listaDropDown = state.listaDropDown;
      final filtros = state.filtros;
      final safra = await upNivel3ConsultaRepository.buscaSafra(
        up1: evento.up1,
      );
      listaDropDown['cdSafra'] = safra;
      yield state.juntar(listaDropDown: listaDropDown, filtros: {
        ...filtros,
        'cdUpnivel1': evento.up1,
        'cdSafra': '',
        'cdUpnivel2': '',
        'cdUpnivel3': '',
      });
    } else if (evento is BuscaUpnivel2) {
      final listaDropDown = state.listaDropDown;
      final filtros = state.filtros;
      final up2 = await upNivel3ConsultaRepository.buscaUp2(
        safra: evento.safra,
      );

      listaDropDown['cdUpnivel2'] = up2;

      yield state.juntar(listaDropDown: listaDropDown, filtros: {
        ...filtros,
        'cdSafra': evento.safra,
        'cdUpnivel2': '',
        'cdUpnivel3': '',
      });
    } else if (evento is BuscaUpnivel3) {
      final listaDropDown = state.listaDropDown;
      final filtros = state.filtros;
      final up3 = await upNivel3ConsultaRepository.buscaUp3(
        up2: evento.up2,
      );
      listaDropDown['cdUpnivel3'] = up3;

      yield state.juntar(listaDropDown: listaDropDown, filtros: {
        ...filtros,
        'cdUpnivel2': evento.up2,
        'cdUpnivel3': '',
      });
    } else if (evento is ConfirmaSelecaoUpNivel3) {
      try {
        final empresa = BaseInherited.of(
          evento.context,
        ).empresaAutenticada;

        final Map<String, dynamic> dispositivo = json.decode(
          await preferenciaRepository.get(idPreferencia: 'dispositivo'),
        );
        if (dispositivo == null) throw Exception('Dispositivo não cadastrado');

        final sequencia =
            await sequenciaRepository.buscarSequencia(empresa: empresa);
        int noSeqAtual = 0;

        final List<EstimativaModelo> estimativas = List();
        final cdFunc =
            BaseInherited.of(evento.context).usuarioAutenticada.cdFunc;
        String mensagemInicial;

        for (var item in state.selecionadas) {
          final existeEstimativa = await estimativaRepository.get(filtros: {
            'cdSafra': item.cdSafra,
            'cdUpnivel1': item.cdUpnivel1,
            'cdUpnivel2': item.cdUpnivel2,
            'cdUpnivel3': item.cdUpnivel3,
            'instancia': empresa.cdInstManfro,
          }).then((value) =>
              value.length > 0 && !value.every((item) => item.status == 'I'));

          if (existeEstimativa) {
            mensagemInicial =
                'Existe estimativa não sincronizada para alguns registros. Efetue a sincronização!';
          } else {
            estimativas.add(item.gerarEstimativa(
              cdFunc: cdFunc,
              noSeq: ++noSeqAtual,
              noBoletim: 10000 + sequencia.sequencia + 1,
              dispositivo: dispositivo['idDispositivo'],
            ));
          }
        }

        navegar(
          context: evento.context,
          pagina: ApontamentoEstimativaPage(
            apontamentos: estimativas,
            criacao: true,
            mensagemInicial: mensagemInicial,
          ),
        );
      } catch (e) {
        print(e);
        yield state.juntar(mensagemErro: e.toString());
      }
    } else if (evento is CheckAllUpNivel3) {
      if (!evento.valor) {
        yield state.juntar(selecionadas: []);
      } else {
        yield state.juntar(selecionadas: state.lista);
      }
    }
  }

  Map<String, dynamic> _formataFiltros(Map<String, dynamic> filtros) {
    final Map<String, dynamic> filtrosFormatados = Map.from(filtros);
    filtrosFormatados.removeWhere((chave, valor) => valor.isEmpty);
    if (filtros['dtInicio'] != null || filtros['dtFim'] != null) {
      final dataInicio = ">= date('${filtros['dtInicio']}') ";
      final dataFinal = "<= date('${filtros['dtFim']}')";

      filtrosFormatados['date(dtUltimoCorte)'] =
          "${filtros['dtInicio'] != null ? dataInicio : ""}"
          "${filtros['dtInicio'] != null && filtros['dtFim'] != null ? " AND date(dtUltimoCorte) " : ""} "
          "${filtros['dtFim'] != null ? dataFinal : ""}";
    }

    filtrosFormatados.remove('dtInicio');
    filtrosFormatados.remove('dtFim');

    return filtrosFormatados;
  }
}
