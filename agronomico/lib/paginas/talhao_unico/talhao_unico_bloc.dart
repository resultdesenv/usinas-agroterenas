import 'dart:convert';

import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:agronomico/comum/repositorios/upnivel3_consulta_repository.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_event.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class TalhaoUnicoBloc extends Bloc<TalhaoUnicoEvent, TalhaoUnicoState> {
  final UpNivel3ConsultaRepository upNivel3ConsultaRepository;
  final PreferenciaRepository preferenciaRepository;
  final Function({
    int cdFunc,
    int dispositivo,
    UpNivel3Model talhao,
  }) callback;

  TalhaoUnicoBloc({
    @required this.upNivel3ConsultaRepository,
    @required this.preferenciaRepository,
    @required this.callback,
  }) : super(TalhaoUnicoState());

  @override
  Stream<TalhaoUnicoState> mapEventToState(TalhaoUnicoEvent event) async* {
    if (event is IniciarTalhaoUnico) {
      yield state.juntar(loading: true);
      try {
        final Map<String, dynamic> filtros = json.decode(
            await preferenciaRepository.get(idPreferencia: 'talhao_filtros') ??
                '{}');

        yield state.juntar(
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
        yield state.juntar(
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
        filtros: event.filtros,
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

    if (event is EscolheTalhao) {
      final Map<String, dynamic> dispositivo = json.decode(
        await preferenciaRepository.get(idPreferencia: 'dispositivo'),
      );
      if (dispositivo == null) throw Exception('Dispositivo não cadastrado');

      callback(
        cdFunc: event.cdFunc,
        dispositivo: dispositivo['idDispositivo'],
        talhao: event.talhao,
      );
    }
  }
}
