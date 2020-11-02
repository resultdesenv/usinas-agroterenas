import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PreferenciaModel extends Equatable {
  final String idPreferencia;
  final Map<String, dynamic> valorPreferencia;

  PreferenciaModel({
    @required this.idPreferencia,
    @required this.valorPreferencia,
  });

  factory PreferenciaModel.deMap({@required Map<String, dynamic> map}) =>
      PreferenciaModel(
        idPreferencia: map['idPreferencia'],
        valorPreferencia: map['valorPreferencia'],
      );

  PreferenciaModel juntar({
    String idPreferencia,
    Map<String, dynamic> valorPreferencia,
  }) =>
      PreferenciaModel(
        idPreferencia: idPreferencia ?? this.idPreferencia,
        valorPreferencia: valorPreferencia ?? this.valorPreferencia,
      );

  Map<String, dynamic> paraMap() => {
        'idPreferencia': idPreferencia,
        'valorPreferencia': valorPreferencia,
      };

  String get preferenciaParaString => json.encode(valorPreferencia);

  @override
  List<Object> get props => [idPreferencia, valorPreferencia];
}
