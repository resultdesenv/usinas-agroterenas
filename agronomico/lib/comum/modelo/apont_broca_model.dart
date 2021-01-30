import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class ApontBrocaModel extends Equatable {
  final int noColetor;
  final String instancia;
  final int noBoletim;
  final int noSequencia;
  final String versao;
  final int cdSafra;
  final String cdUpnivel1;
  final String cdUpnivel2;
  final String cdUpnivel3;
  final double qtBrocados;
  final double qtCanaPodr;
  final double qtCanas;
  final double qtCanasbroc;
  final double qtEntrPodr;
  final double qtEntrenos;
  final double qtMedia;
  final int cdFunc;
  final String dtOperacao;
  final String hrOperacao;
  final String status;
  final String dtStatus;

  ApontBrocaModel({
    @required this.noColetor,
    @required this.instancia,
    @required this.noBoletim,
    @required this.noSequencia,
    @required this.versao,
    @required this.cdSafra,
    @required this.cdUpnivel1,
    @required this.cdUpnivel2,
    @required this.cdUpnivel3,
    @required this.qtBrocados,
    @required this.qtCanaPodr,
    @required this.qtCanas,
    @required this.qtCanasbroc,
    @required this.qtEntrPodr,
    @required this.qtEntrenos,
    @required this.qtMedia,
    @required this.cdFunc,
    @required this.dtOperacao,
    @required this.hrOperacao,
    @required this.status,
    @required this.dtStatus,
  });

  factory ApontBrocaModel.fromJson(Map<String, dynamic> json) =>
      ApontBrocaModel(
        noColetor: json['noColetor'],
        instancia: json['instancia'],
        noBoletim: json['noBoletim'],
        noSequencia: json['noSequencia'],
        versao: json['versao'],
        cdSafra: json['cdSafra'],
        cdUpnivel1: json['cdUpnivel1'],
        cdUpnivel2: json['cdUpnivel2'],
        cdUpnivel3: json['cdUpnivel3'],
        qtBrocados: json['qtBrocados'],
        qtCanaPodr: json['qtCanaPodr'],
        qtCanas: json['qtCanas'],
        qtCanasbroc: json['qtCanasbroc'],
        qtEntrPodr: json['qtEntrPodr'],
        qtEntrenos: json['qtEntrenos'],
        qtMedia: json['qtMedia'],
        cdFunc: json['cdFunc'],
        dtOperacao: json['dtOperacao'],
        hrOperacao: json['hrOperacao'],
        status: json['status'],
        dtStatus: json['dtStatus'],
      );

  @override
  List<Object> get props => [
        noColetor,
        instancia,
        noBoletim,
        noSequencia,
        versao,
        cdSafra,
        cdUpnivel1,
        cdUpnivel2,
        cdUpnivel3,
        qtBrocados,
        qtCanaPodr,
        qtCanas,
        qtCanasbroc,
        qtEntrPodr,
        qtEntrenos,
        qtMedia,
        cdFunc,
        dtOperacao,
        hrOperacao,
        status,
        dtStatus,
      ];
}
