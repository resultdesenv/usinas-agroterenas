import 'package:apontamento/comun/modelo/safra_model.dart';
import 'package:meta/meta.dart';
import 'package:apontamento/comun/db/db.dart';

class SafraRepository {
  final Db db;

  SafraRepository({@required this.db});

  Future<List<SafraModel>> buscarSafras() async {
    final dbInstance = await db.get();
    final listagemJson = await dbInstance.query('safra');
    return listagemJson
        .map<SafraModel>((item) => SafraModel.fromJson(item))
        .toList();
  }
}
