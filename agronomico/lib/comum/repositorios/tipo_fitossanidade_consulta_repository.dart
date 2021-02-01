import 'package:agronomico/comum/modelo/tipo_fitossanidade_model.dart';
import 'package:meta/meta.dart';
import 'package:agronomico/comum/db/db.dart';

class TipoFitossanidadeConsultaRepository {
  final Db db;

  TipoFitossanidadeConsultaRepository({@required this.db});

  Future<List<TipoFitossanidadeModel>> get() async {
    final dbInstance = await db.get();
    final listagemJson =
        await dbInstance.query('tipo_fitossanidade', orderBy: 'deFitoss ASC');
    return listagemJson
        .map((item) => TipoFitossanidadeModel.fromJson(item))
        .toList();
  }
}
