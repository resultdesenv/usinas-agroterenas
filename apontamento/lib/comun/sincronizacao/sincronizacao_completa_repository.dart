import 'package:apontamento/comun/sincronizacao/sincronizacao_base.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class SincronizacaoCompletaRepository {
  final List<SincronizacaoBase> list;

  SincronizacaoCompletaRepository({@required this.list});

  index(String token, {Dio dio}) async {
    for (final item in list) {
      if (dio != null) item.updateDio(dio);
      await item.index(token);
    }
  }
}
