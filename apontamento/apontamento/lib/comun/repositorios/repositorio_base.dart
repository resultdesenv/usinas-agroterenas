abstract class RepositorioBase<Model> {
  Future<List<Model>> get();
  Future<bool> sincronizarSaida();
  Future<bool> salvar(List<Model> list);
}
