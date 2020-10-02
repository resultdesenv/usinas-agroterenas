import 'package:dio/dio.dart';

abstract class SincronizacaoBase<Model> {
  index(
    String token, {
    String cdInstManfro,
    String cdSafra,
  });

  updateDio(Dio dio);
}
