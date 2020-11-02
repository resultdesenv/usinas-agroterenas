import 'package:agronomico/comum/modelo/empresa_model.dart';
import 'package:agronomico/comum/modelo/safra_model.dart';
import 'package:agronomico/comum/modelo/sincronizacao_item_atualizacao_model.dart';
import 'package:meta/meta.dart';

abstract class SincronizacaoEvent {}

class BuscarItensSincronizacao extends SincronizacaoEvent {
  final List<HistoricoItemAtualizacaoModel> itensSincronizacao;

  BuscarItensSincronizacao({@required this.itensSincronizacao});
}

class SincronizarItem extends SincronizacaoEvent {
  final HistoricoItemAtualizacaoModel historicoItemAtualizacaoModel;
  final EmpresaModel empresaModel;

  SincronizarItem(
      {@required this.historicoItemAtualizacaoModel,
      @required this.empresaModel});
}

class SincronizarTudo extends SincronizacaoEvent {
  final List<HistoricoItemAtualizacaoModel> itensSincronizacao;
  final EmpresaModel empresaModel;

  SincronizarTudo(
      {@required this.itensSincronizacao,
      @required this.empresaModel});
}

class SelecionarSafra extends SincronizacaoEvent {
  final SafraModel safra;

  SelecionarSafra({@required this.safra});
}
