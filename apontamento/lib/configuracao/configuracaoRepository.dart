import 'configuracao_model.dart';

class ConfiguracaoRepository {
  Future<ConfiguracaoModel> buscarConfiguracoes(String chave) async {
    await Future.delayed(Duration(seconds: 2));

    if (chave == 'prod')
      return ConfiguracaoModel(
          chave: chave, url: 'http://portal.agroterenas.com.br:8283/');

    if (chave == 'demo')
      return ConfiguracaoModel(
          chave: chave, url: 'http://demo.portal.agroterenas.com.br:8283/');

    throw Exception('Usuario não encontrado');
  }
}
