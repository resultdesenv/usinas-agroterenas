import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:agronomico/comum/repositorios/apont_broca_consulta_repository.dart';
import 'package:agronomico/comum/repositorios/preferencia_repository.dart';
import 'package:agronomico/comum/repositorios/sequencia_repository.dart';
import 'package:agronomico/comum/repositorios/tipo_fitossanidade_consulta_repository.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_event.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_moment/simple_moment.dart';

class ApontamentoBrocaFormBloc
    extends Bloc<ApontamentoBrocaFormEvent, ApontamentoBrocaFormState> {
  final ApontBrocaConsultaRepository repositorioBroca;
  final SincronizacaoSequenciaRepository repositorioSequencia;
  final TipoFitossanidadeConsultaRepository repositorioFitossanidade;
  final PreferenciaRepository repositorioPreferencia;

  ApontamentoBrocaFormBloc({
    @required this.repositorioBroca,
    @required this.repositorioSequencia,
    @required this.repositorioFitossanidade,
    @required this.repositorioPreferencia,
  }) : super(ApontamentoBrocaFormState());

  @override
  Stream<ApontamentoBrocaFormState> mapEventToState(
    ApontamentoBrocaFormEvent event,
  ) async* {
    if (event is IniciarFormBrocas) {
      try {
        yield state.juntar(carregando: true);
        final tiposFitossanidade = await repositorioFitossanidade.get();
        final prefFitoss = await repositorioPreferencia.get(
          idPreferencia: 'tipo-fitossanidade',
        );
        final cdFitoss =
            (prefFitoss != null ? int.tryParse(prefFitoss) : prefFitoss) ??
                tiposFitossanidade?.first?.cdFitoss;
        List<ApontBrocaModel> brocas;
        String mensagemErro;

        if (event.novoApontamento) {
          brocas = await repositorioBroca.get(
              filtros: Map.from({
            'cdUpnivel1': event.upnivel3.cdUpnivel1,
            'cdUpnivel2': event.upnivel3.cdUpnivel2,
            'cdUpnivel3': event.upnivel3.cdUpnivel3,
          }));

          if (event.novoApontamento && brocas.length > 0) {
            mensagemErro = 'Esse talhão ja possui um apontamento, abrindo...';
          } else {
            final prefCana = await repositorioPreferencia.get(
              idPreferencia: 'quantidade-canas',
            );
            final qtCana =
                (prefCana != null ? int.tryParse(prefCana) : prefCana) ?? 100;
            int noSeqAtual = 0;
            brocas = List(qtCana)
                .map((_) => ApontBrocaModel.fromUpnivel3(
                      event.upnivel3,
                      instancia: event.instancia,
                      noBoletin: event.noBoletim,
                      noSequencia: ++noSeqAtual,
                      dispositivo: event.dispositivo,
                      cdFunc: event.cdFunc,
                      cdFitoss: cdFitoss,
                    ))
                .toList();
          }
        } else {
          final Map<String, dynamic> filtros = Map();
          filtros['noBoletim'] = event.noBoletim;
          brocas = await repositorioBroca.get(filtros: filtros);
        }
        print('event.novoApontamento');
        print(event.novoApontamento);
        yield state.juntar(
          brocas: brocas,
          carregando: false,
          tiposFitossanidade: tiposFitossanidade,
          novoApontamento: event.novoApontamento,
          tipoFitossanidade:
              brocas.first != null ? brocas.first.cdFitoss : null,
          mensagemErro: mensagemErro,
        );
      } catch (e) {
        print(e);
        yield state.juntar(
          mensagemErro: e.toString(),
          carregando: false,
        );
      }
    }

    if (event is AlteraTipoBroca) {
      try {
        final brocas = event.brocas
            .map((e) => e.juntar(cdFitoss: event.cdFitoss))
            .toList();
        yield state.juntar(brocas: brocas);
        await repositorioPreferencia.salvar(
          idPreferencia: 'tipo-fitossanidade',
          valorPreferencia: event.cdFitoss,
        );
      } catch (e) {
        print(e);
        yield state.juntar(mensagemErro: e.toString());
      }
    }

    if (event is AlteraApontamento) {
      final brocas = state.brocas;
      brocas[event.indiceBroca] = event.broca;
      yield state.juntar(brocas: brocas);
    }

    if (event is SalvarApontamentos) {
      yield state.juntar(carregando: true);
      final brocas = event.brocas
          .map((e) => e.juntar(
                qtCanasbroc: e.qtBrocados > 0 ? 1 : 0,
                qtCanas: 1,
                dtOperacao: Moment.now().format('yyyy-MM-dd'),
                dtStatus: Moment.now().format('yyyy-MM-dd'),
                hrOperacao: Moment.now().format('yyyy-MM-dd HH:mm:ss'),
                status: 'P',
              ))
          .toList();
      try {
        await repositorioBroca.salvar(brocas);

        if (state.novoApontamento) {
          final sequencia = await repositorioSequencia.buscarSequencia(
            empresa: event.empresa,
          );
          await repositorioSequencia.salvarSequencia(
            sequencia: sequencia.juntar(sequencia: sequencia.sequencia + 1),
          );
        }

        yield state.juntar(
          carregando: false,
          voltarParaListagem: event.voltar,
          brocas: brocas,
        );
      } catch (e) {
        print(e);
        yield state.juntar(
            carregando: false, mensagemErro: e.toString(), brocas: brocas);
      }
    }

    if (event is AlteraQuantidade) {
      if (event.quantidade == 0) return;
      if (event.quantidade <= event.brocas.length) {
        yield state.juntar(brocas: event.brocas.sublist(0, event.quantidade));
      } else {
        final diferenca = event.quantidade - event.brocas.length;
        int sequencia = event.brocas.length;

        final novasBrocas = List(diferenca)
            .map((_) => ApontBrocaModel(
                  instancia: event.brocas.first?.instancia,
                  noBoletim: event.brocas.first?.noBoletim,
                  noSequencia: ++sequencia,
                  dispositivo: event.brocas.first?.dispositivo,
                  cdFunc: event.brocas.first?.cdFunc,
                  cdFitoss: event.brocas.first?.cdFitoss,
                  cdSafra: event.brocas.first?.cdSafra,
                  cdUpnivel1: event.brocas.first?.cdUpnivel1,
                  cdUpnivel2: event.brocas.first?.cdUpnivel2,
                  cdUpnivel3: event.brocas.first?.cdUpnivel3,
                  dtOperacao: null,
                  dtStatus: null,
                  hrOperacao: null,
                  noColetor: event.brocas.first?.noColetor,
                  qtBrocados: 0,
                  qtCanas: 1,
                  qtCanaPodr: 0,
                  qtCanasbroc: 0,
                  qtEntrPodr: 0,
                  qtEntrenos: 0,
                  qtMedia: 0,
                  status: 'P',
                  versao: null,
                ))
            .toList();
        yield state.juntar(brocas: event.brocas + novasBrocas);
      }
      try {
        await repositorioPreferencia.salvar(
          idPreferencia: 'quantidade-canas',
          valorPreferencia: event.quantidade,
        );
      } catch (e) {
        print(e);
        yield state.juntar(mensagemErro: e.toString());
      }
    }
  }
}
