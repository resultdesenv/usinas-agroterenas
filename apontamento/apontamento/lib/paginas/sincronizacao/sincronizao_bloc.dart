import 'package:apontamento/comun/modelo/sincronizacao_item_atualizacao_model.dart';
import 'package:apontamento/comun/repositorios/safra_repository.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_autenticacao.dart';
import 'package:apontamento/comun/sincronizacao/sincronizacao_historico_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'sincronizacao.dart';

class SincronizacaoBloc extends Bloc<SincronizacaoEvent, SincronizacaoState> {
  final SincronizacaoHistoricoRepository sincronizacaoHistoricoRepository;
  final SincronizacaoAutenticacao sincronizacaoAutenticacao;
  final SafraRepository safraRepository;

  SincronizacaoBloc({
    @required this.sincronizacaoHistoricoRepository,
    @required this.sincronizacaoAutenticacao,
    @required this.safraRepository,
  }) : super(SincronizacaoState());

  @override
  Stream<SincronizacaoState> mapEventToState(SincronizacaoEvent event) async* {
    if (event is BuscarItensSincronizacao) {
      final historicoSincronizacao =
          await this.sincronizacaoHistoricoRepository.buscarHistorico();

      final itensSincronizacao = event.itensSincronizacao
          .map<HistoricoItemAtualizacaoModel>((itemSincronizacao) {
        final historico = historicoSincronizacao
            .where((e) => e.tabela == itemSincronizacao.tabela)
            .toList();

        final dataAtualizacao =
            historico.length == 0 ? null : historico[0].dataAtualizacao;
        return itemSincronizacao.copyWith(dataAtualizacao: dataAtualizacao);
      }).toList();

      print(itensSincronizacao[itensSincronizacao.length - 1].upnivel3);

      final safras = await safraRepository.buscarSafras();

      yield state.copyWith(
          itensSincronizacao: itensSincronizacao, safras: safras);
    }

    if (event is SincronizarItem) {
      try {
        final novaListaComLoading = state.itensSincronizacao.map((item) {
          if (item.tabela == event.historicoItemAtualizacaoModel.tabela)
            return item.copyWith(atualizando: true);
          return item;
        }).toList();

        yield state.copyWith(itensSincronizacao: novaListaComLoading);

        final token = await sincronizacaoAutenticacao.index();
        await event.historicoItemAtualizacaoModel.repository.index(token,
            cdInstManfro: event.empresaModel?.cdInstManfro,
            cdSafra: state.safraSelecionada?.cdSafra?.toString());

        final historicoAtualizacao =
            await sincronizacaoHistoricoRepository.buscarHistorico();

        final novaDataAtualizacao = historicoAtualizacao
            .firstWhere((item) =>
                item.tabela == event.historicoItemAtualizacaoModel.tabela)
            .dataAtualizacao;

        final novaListaSemLoading = novaListaComLoading.map((item) {
          if (item.tabela == event.historicoItemAtualizacaoModel.tabela)
            return item.copyWith(
                atualizando: false, dataAtualizacao: novaDataAtualizacao);
          return item;
        }).toList();

        yield state.copyWith(itensSincronizacao: novaListaSemLoading);
      } catch (e) {
        yield state.copyWith(
            itensSincronizacao: state.itensSincronizacao
                .map((e) => e.copyWith(atualizando: false))
                .toList(),
            mensagem: e.toString());
      }
    }

    if (event is SelecionarSafra) {
      yield state.copyWith(safraSelecionada: event.safra);
    }
  }

}
