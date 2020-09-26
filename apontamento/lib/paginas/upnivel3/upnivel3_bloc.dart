import 'dart:convert';

import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comum/modelo/estimativa_modelo.dart';
import 'package:apontamento/comum/modelo/upnivel3_model.dart';
import 'package:apontamento/comum/repositorios/upnivel3_consulta_repository.dart';
import 'package:apontamento/comum/repositorios/preferencia_repository.dart';
import 'package:apontamento/comum/repositorios/repositorio_estimativa.dart';
import 'package:apontamento/comum/repositorios/sequencia_repository.dart';
import 'package:apontamento/comum/utilidades/navegacao.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_page.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_event.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_state.dart';
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
          await preferenciaRepository.get(idPreferencia: 'upnivel3Filtros'));
      final Map<String, List<String>> listaDropDown =
          await upNivel3ConsultaRepository.buscaDropDow();

      yield state.juntar(
        filtros: filtros,
        listaDropDown: listaDropDown,
      );
    } else if (evento is ConfirmaSelecaoUpNivel3) {
      try {
        final empresa = BaseInherited.of(
          evento.context,
        ).empresaAutenticada;

        final Map<String, dynamic> dispositivo = json.decode(
          await preferenciaRepository.get(idPreferencia: 'dispositivo'),
        );
        final sequencia =
            await sequenciaRepository.buscarSequencia(empresa: empresa);
        if (dispositivo == null) throw Exception('Dispositivo não cadastrado');

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
          }).then((value) => value.length > 0);

          if (existeEstimativa) {
            mensagemInicial =
                'Já existe estimativa para alguns registros. Removendo estes da lista!';
          } else {
            estimativas.add(item.gerarEstimativa(
              cdFunc: cdFunc,
              noSeq: sequencia.sequencia + 1,
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
      print(evento.valor);
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
