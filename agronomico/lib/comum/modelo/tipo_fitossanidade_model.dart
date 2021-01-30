import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class TipoFitossanidadeModel extends Equatable {
  final int cdFitoss;
  final String deFitoss;

  TipoFitossanidadeModel({
    @required this.cdFitoss,
    @required this.deFitoss,
  });

  factory TipoFitossanidadeModel.fromJson(Map<String, dynamic> json) =>
      TipoFitossanidadeModel(
        cdFitoss: json['cdFitoss'],
        deFitoss: json['deFitoss'],
      );

  Map<String, dynamic> toJson() => {
        'cdFitoss': cdFitoss,
        'deFitoss': deFitoss,
      };

  @override
  List<Object> get props => [cdFitoss, deFitoss];
}
