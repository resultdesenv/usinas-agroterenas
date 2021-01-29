import 'package:agronomico/comum/modelo/dispositivo_model.dart';
import 'package:agronomico/comum/utilidades/custom_exception.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

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

    throw CustomException('Usuario não encontrado');
  }

  Future<String> _autenticar({
    @required String url,
  }) async {
    final dio = Dio(BaseOptions(baseUrl: url));
    final res = await dio.post('/agt-api-pims/autenticacao', data: {
      "username": "agtestimativa",
      "password":
          "5E30F86F9024CB774DF4D834C57AD9FE6EB0EE63432B454C3675071D603CB7F6"
    });
    return res.data['token'];
  }

  Future<DispositivoModel> cadastrarDispositivo({
    @required String url,
    @required String imei,
  }) async {
    final token = await _autenticar(url: url);
    print('token $token');
    final dio = Dio(
        BaseOptions(baseUrl: url, headers: {'authorization': 'Bearer $token'}));
    final res = await dio.post('/agt-api-pims/api/dispositivo/registro', data: {
      "cartaoSim": "",
      "idAndroid": imei,
      "imei": imei,
      "situacao": "A"
    });
    return DispositivoModel.fromJson(res.data);
  }
}
