import 'package:apontamento/base/base_inherited.dart';
import 'package:apontamento/comun/modelo/estimativa_modelo.dart';
import 'package:apontamento/comun/modelo/preferencia_model.dart';
import 'package:apontamento/comun/modelo/upnivel3_model.dart';
import 'package:apontamento/comun/repositorios/epnivel3_consulta_repository.dart';
import 'package:apontamento/comun/repositorios/preferencia_repository.dart';
import 'package:apontamento/comun/repositorios/repositorio_estimativa.dart';
import 'package:apontamento/comun/utilidades/navegacao.dart';
import 'package:apontamento/paginas/apontamento_estimativa_form/apontamento_estimativa_pagina.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_event.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class UpNivel3Bloc extends Bloc<UpNivel3Event, UpNivel3State> {
  final UpNivel3ConsultaRepository upNivel3ConsultaRepository;
  final PreferenciaRepository preferenciaRepository;
  final RepositorioEstimativa estimativaRepository;

  UpNivel3Bloc({
    @required this.upNivel3ConsultaRepository,
    @required this.preferenciaRepository,
    @required this.estimativaRepository,
  }) : super(UpNivel3State());

  @override
  Stream<UpNivel3State> mapEventToState(UpNivel3Event evento) async* {
    if (evento is AlterarFiltroUpNivel3) {
      final Map<String, String> filtros = Map.from(state.filtros);

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

        final res =
            await upNivel3ConsultaRepository.get(filtros: evento.filtros);

        if (evento.salvaFiltros)
          await preferenciaRepository.salvar(
            preferencia: PreferenciaModel(
              idPreferencia: 'upnivel3',
              valorPreferencia: evento.filtros,
            ),
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
      final Map<String, String> filtros =
          await preferenciaRepository.get(idPreferencia: 'upnivel3');
      final Map<String, List<String>> listaDropDown =
          await upNivel3ConsultaRepository.buscaDropDow();

      yield state.juntar(
        filtros: filtros,
        listaDropDown: listaDropDown,
      );
    } else if (evento is ConfirmaSelecaoUpNivel3) {
      final instancia = BaseInherited.of(
        evento.context,
      ).empresaAutenticada.cdInstManfro;
      final List<EstimativaModelo> estimativas = List();
      final cdFunc = BaseInherited.of(evento.context).usuarioAutenticada.cdFunc;
      int noSeq = 1;
      String mensagemInicial;

      for (var item in state.selecionadas) {
        final existeEstimativa = await estimativaRepository.get(filtros: {
          'cdSafra': item.cdSafra,
          'cdUpnivel1': item.cdUpnivel1,
          'cdUpnivel2': item.cdUpnivel2,
          'cdUpnivel3': item.cdUpnivel3,
          'instancia': instancia,
        }).then((value) => value.length > 0);

        if (existeEstimativa) {
          mensagemInicial =
              'Já existe estimativa para alguns registros. Removendo estes da lista!';
        } else {
          estimativas.add(item.gerarEstimativa(
            cdFunc: cdFunc,
            // TIRAR O MOCK QUANDO POSSIVEL
            noSeq: noSeq++,
            noBoletim: 44547,
            dispositivo: 1,
            // TIRAR O MOCK QUANDO POSSIVEL
          ));
        }

        navegar(
          context: evento.context,
          pagina: ApontamentoEstimativaPagina(
            apontamentos: estimativas,
            criacao: true,
            mensagemInicial: mensagemInicial,
          ),
        );
      }
    }
  }
}
