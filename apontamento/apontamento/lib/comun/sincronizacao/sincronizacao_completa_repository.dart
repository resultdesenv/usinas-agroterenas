import 'package:apontamento/comun/sincronizacao/sincronizacao_base.dart';
import 'package:meta/meta.dart';

class SincronizacaoCompletaRepository {
  final List<SincronizacaoBase> list;

  SincronizacaoCompletaRepository({@required this.list});

  index(String token) async {
    for (final item in list) {
      await item.index(token);
      print(item.toString());
    }
  }
}
