import 'package:equatable/equatable.dart';

class ConfiguracaoModel extends Equatable {
  final String chave;
  final String url;

  ConfiguracaoModel({this.chave, this.url});

  List<Object> get props => [chave, url];
}
