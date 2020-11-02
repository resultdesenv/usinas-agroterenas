import 'package:agronomico/comum/modelo/estimativa_modelo.dart';
import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:agronomico/comum/repositorios/repositorio_estimativa.dart';
import 'package:agronomico/comum/repositorios/sequencia_repository.dart';
import 'package:agronomico/comum/repositorios/upnivel3_consulta_repository.dart';
import 'package:agronomico/paginas/apontamento_estimativa_form/apontamento_estimativa_state.dart';
import 'package:agronomico/paginas/apontamento_estimativa_form/apontamento_estimativa_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class ApontamentoEstimativaBloc
    extends Bloc<ApontamentoEstimativaEvento, ApontamentoEstimativaState> {
  final RepositorioEstimativa repositorioEstimativa;
  final SincronizacaoSequenciaRepository sequenciaRepository;
  final UpNivel3ConsultaRepository upNivel3ConsultaRepository;

  ApontamentoEstimativaBloc({
    @required this.repositorioEstimativa,
    @required this.sequenciaRepository,
    @required this.upNivel3ConsultaRepository,
    @required bool criacao,
  }) : super(ApontamentoEstimativaState(criacao: criacao));

  @override
  Stream<ApontamentoEstimativaState> mapEventToState(
    ApontamentoEstimativaEvento evento,
  ) async* {
    if (evento is AdicionarApontamento) {
      yield state.juntar(loading: true);
      final apontamentos = [
        ...state.apontamentos,
        ...evento.apontamentos,
      ];
      try {
        final List<UpNivel3Model> apontIniciais = List();
        for (EstimativaModelo apontamento in apontamentos) {
          final upnivel = await upNivel3ConsultaRepository.getByPks(
            cdUpnivel1: apontamento.cdUpnivel1,
            cdUpnivel2: apontamento.cdUpnivel2,
            cdUpnivel3: apontamento.cdUpnivel3,
            cdSafra: apontamento.cdSafra,
          );
          if (upnivel != null) apontIniciais.add(upnivel);
        }

        yield state.juntar(
          loading: false,
          apontamentos: apontamentos,
          mensagemErro: evento.mensagemInicial,
          apontIniciais: apontIniciais,
        );
      } catch (e) {
        state.juntar(
          loading: false,
          apontamentos: apontamentos,
          mensagemErro:
              'Falha ao carregar informação de campos iniciais upnivel',
        );
      }
    } else if (evento is EditarApontamento) {
      final apontamentos = state.apontamentos;
      apontamentos[evento.indice] = evento.apontamento;
      yield state.juntar(apontamentos: apontamentos);
    } else if (evento is ApagarApontamentos) {
      try {
        final res = await repositorioEstimativa.removerItens(
          state.apontamentos,
        );

        yield state.juntar(
          loading: false,
          mensagemErro: res ? null : 'Não foi possivel remover as estimativas!',
          edicaoConcluida: res,
        );
      } catch (e) {
        print(e);
        yield state.juntar(loading: false, mensagemErro: e.toString());
      }
    } else if (evento is SalvarApontamentos) {
      try {
        yield state.juntar(loading: true);

        final res = state.criacao
            ? await repositorioEstimativa.salvar(evento.estimativas)
            : await repositorioEstimativa.atualizarItens(evento.estimativas);

        yield state.juntar(
          loading: false,
          mensagemErro: res ? null : 'Não foi possivel salvar as estimativas!',
        );

        if (state.criacao) {
          final sequencia = await sequenciaRepository.buscarSequencia(
            empresa: evento.empresa,
          );
          await sequenciaRepository.salvarSequencia(
            sequencia: sequencia.juntar(sequencia: sequencia.sequencia + 1),
          );
        }
        yield state.juntar(edicaoConcluida: true);
      } catch (e) {
        print(e);
        yield state.juntar(loading: false, mensagemErro: e.toString());
      }
    } else if (evento is ReplicarApontamentos) {
      final List<EstimativaModelo> apontamentos = state.apontamentos
          .map((a) => a.copiarCom(
                tch0: double.parse(evento.tch0),
                tch1: double.parse(evento.tch1),
                tch2: double.parse(evento.tch2),
                tch3: double.parse(evento.tch3),
                tch4: double.parse(evento.tch4),
              ))
          .toList();
      yield state.juntar(apontamentos: apontamentos);
    }
  }
}
