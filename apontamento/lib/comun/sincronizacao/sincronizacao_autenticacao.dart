import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class SincronizacaoAutenticacao {
  Dio dio;

  SincronizacaoAutenticacao({@required this.dio});

  updateDio(Dio dio) {
    this.dio = dio;
  }

  Future<String> index() async {
    final res = await this.dio.post('/agt-api-pims/autenticacao', data: {
      'username': 'agtestimativa',
      'password':
          '5E30F86F9024CB774DF4D834C57AD9FE6EB0EE63432B454C3675071D603CB7F6',
    });
    return res.data['token'];
  }
}
