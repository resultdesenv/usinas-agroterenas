import 'dart:convert';

import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:agronomico/comum/repositorios/upnivel3_consulta_repository.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_event.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class TalhaoUnicoBloc extends Bloc<TalhaoUnicoEvent, TalhaoUnicoState> {
  final UpNivel3ConsultaRepository upNivel3ConsultaRepository;
  final PreferenciaRepository preferenciaRepository;

  TalhaoUnicoBloc({
    @required this.upNivel3ConsultaRepository,
    @required this.preferenciaRepository,
  }) : super(TalhaoUnicoState());

  @override
  Stream<TalhaoUnicoState> mapEventToState(TalhaoUnicoEvent event) async* {
    if (event is IniciarTalhaoUnico) {
      yield state.juntar(loading: true);
      try {
        final Map<String, dynamic> filtros = json.decode(
            await preferenciaRepository.get(idPreferencia: 'talhao_filtros') ??
                '{}');
        final up2 = await upNivel3ConsultaRepository.buscaUp2();
        final listaDropDown = {
          'cdUpnivel2': up2,
        };

        filtros.keys.forEach((chave) {
          if (filtros[chave] != null && filtros[chave].toString().isNotEmpty) {
            listaDropDown[chave] = [filtros[chave]];
          }
        });

        yield state.juntar(
          listaDropDown: listaDropDown,
          filtros: filtros,
          loading: false,
        );
      } catch (e) {
        print(e);
        yield state.juntar(loading: false, mensagemErro: e.toString());
      }
    }

    if (event is BuscaSafra) {
      yield state.juntar(loading: true);
      try {
        final listaDropDown = state.listaDropDown;
        final safra =
            await upNivel3ConsultaRepository.buscaSafra(up2: event.up2);
        listaDropDown['cdSafra'] = safra;
        yield state.juntar(
          listaDropDown: listaDropDown,
          filtros: {
            ...state.filtros,
            'cdUpnivel2': event.up2,
            'cdSafra': '',
          },
          loading: false,
        );
      } catch (e) {
        print(e);
        yield state.juntar(loading: false, mensagemErro: e.toString());
      }
    }

    if (event is BuscaListaTalhoes) {
      yield state.juntar(
        loading: true,
        talhoes: [],
      );
      try {
        final res = await upNivel3ConsultaRepository.get(
          filtros: event.filtros,
        );

        if (event.salvaFiltros)
          await preferenciaRepository.salvar(
            idPreferencia: 'talhao_filtros',
            valorPreferencia: json.encode(event.filtros),
          );

        yield state.juntar(
          loading: false,
          talhoes: res,
          filtros: event.filtros,
        );
      } catch (e) {
        print(e);
        yield state.juntar(loading: false, mensagemErro: e.toString());
      }
    }

    if (event is AlteraFiltros) {
      yield state.juntar(filtros: event.filtros);
    }
  }
}
