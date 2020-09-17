import 'package:apontamento/comun/modelo/empresa_model.dart';
import 'package:apontamento/comun/modelo/safra_model.dart';
import 'package:apontamento/comun/modelo/sincronizacao_item_atualizacao_model.dart';
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

class SelecionarSafra extends SincronizacaoEvent {
  final SafraModel safra;

  SelecionarSafra({@required this.safra});
}
