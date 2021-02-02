import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:agronomico/comum/repositorios/apont_broca_consulta_repository.dart';
import 'package:agronomico/comum/repositorios/sequencia_repository.dart';
import 'package:agronomico/comum/repositorios/tipo_fitossanidade_consulta_repository.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_event.dart';
import 'package:agronomico/paginas/apontamento_broca_form/apontamento_broca_form_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class ApontamentoBrocaFormBloc
    extends Bloc<ApontamentoBrocaFormEvent, ApontamentoBrocaFormState> {
  final ApontBrocaConsultaRepository repositorioBroca;
  final SincronizacaoSequenciaRepository repositorioSequencia;
  final TipoFitossanidadeConsultaRepository repositorioFitossanidade;

  ApontamentoBrocaFormBloc({
    @required this.repositorioBroca,
    @required this.repositorioSequencia,
    @required this.repositorioFitossanidade,
  }) : super(ApontamentoBrocaFormState());

  @override
  Stream<ApontamentoBrocaFormState> mapEventToState(
    ApontamentoBrocaFormEvent event,
  ) async* {
    if (event is IniciarFormBrocas) {
      try {
        yield state.juntar(carregando: true);
        final tiposFitossanidade = await repositorioFitossanidade.get();
        List<ApontBrocaModel> brocas;

        if (event.novoApontamento) {
          int noSeqAtual = 0;
          brocas = List(100)
              .map((_) => ApontBrocaModel.fromUpnivel3(
                    event.upnivel3,
                    noBoletin: event.noBoletim,
                    noSequencia: ++noSeqAtual,
                    dispositivo: event.dispositivo,
                    cdFunc: event.cdFunc,
                  ))
              .toList();
        } else {
          final Map<String, dynamic> filtros = Map();
          filtros['noBoletim'] = event.noBoletim;
          brocas = await repositorioBroca.get(filtros: filtros);
        }
        yield state.juntar(
          brocas: brocas,
          carregando: false,
          tiposFitossanidade: tiposFitossanidade,
          novoApontamento: event.novoApontamento,
          tipoFitossanidade:
              brocas.first != null ? brocas.first.cdFitoss : null,
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
      final brocas =
          event.brocas.map((e) => e.juntar(cdFitoss: event.cdFitoss)).toList();
      yield state.juntar(brocas: brocas);
    }

    if (event is AlteraApontamento) {
      final brocas = state.brocas;
      brocas[event.indiceBroca] = event.broca;
      yield state.juntar(brocas: brocas);
    }

    if (event is SalvarApontamentos) {
      yield state.juntar(carregando: true);
      try {
        double qtCanasbroc = 0;
        event.brocas.forEach((e) {
          if (e.qtBrocados > 0) qtCanasbroc++;
        });

        final brocas = event.brocas
            .map((e) => e.juntar(
                  qtCanasbroc: qtCanasbroc,
                  qtCanas: event.brocas.length.toDouble(),
                ))
            .toList();
        await repositorioBroca.salvar(brocas);

        if (state.novoApontamento) {
          final sequencia = await repositorioSequencia.buscarSequencia(
            empresa: event.empresa,
          );
          await repositorioSequencia.salvarSequencia(
            sequencia: sequencia.juntar(sequencia: sequencia.sequencia + 1),
          );
        }

        yield state.juntar(carregando: false, voltarParaListagem: true);
      } catch (e) {
        print(e);
        yield state.juntar(carregando: false, mensagemErro: e.toString());
      }
    }
  }
}
