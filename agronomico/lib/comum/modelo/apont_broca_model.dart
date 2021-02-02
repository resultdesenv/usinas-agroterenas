import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_moment/simple_moment.dart';

class ApontBrocaModel extends Equatable {
  final int noColetor;
  final String instancia;
  final int noBoletim;
  final int noSequencia;
  final int cdFitoss;
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
  final int dispositivo;

  ApontBrocaModel({
    @required this.noColetor,
    @required this.cdFitoss,
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
    @required this.dispositivo,
  });

  ApontBrocaModel juntar({
    int noColetor,
    String instancia,
    int noBoletim,
    int noSequencia,
    int cdFitoss,
    String versao,
    int cdSafra,
    String cdUpnivel1,
    String cdUpnivel2,
    String cdUpnivel3,
    double qtBrocados,
    double qtCanaPodr,
    double qtCanas,
    double qtCanasbroc,
    double qtEntrPodr,
    double qtEntrenos,
    double qtMedia,
    int cdFunc,
    String dtOperacao,
    String hrOperacao,
    String status,
    String dtStatus,
    int dispositivo,
  }) =>
      ApontBrocaModel(
        noColetor: noColetor ?? this.noColetor,
        instancia: instancia ?? this.instancia,
        noBoletim: noBoletim ?? this.noBoletim,
        noSequencia: noSequencia ?? this.noSequencia,
        cdFitoss: cdFitoss ?? this.cdFitoss,
        versao: versao ?? this.versao,
        cdSafra: cdSafra ?? this.cdSafra,
        cdUpnivel1: cdUpnivel1 ?? this.cdUpnivel1,
        cdUpnivel2: cdUpnivel2 ?? this.cdUpnivel2,
        cdUpnivel3: cdUpnivel3 ?? this.cdUpnivel3,
        qtBrocados: qtBrocados ?? this.qtBrocados,
        qtCanaPodr: qtCanaPodr ?? this.qtCanaPodr,
        qtCanas: qtCanas ?? this.qtCanas,
        qtCanasbroc: qtCanasbroc ?? this.qtCanasbroc,
        qtEntrPodr: qtEntrPodr ?? this.qtEntrPodr,
        qtEntrenos: qtEntrenos ?? this.qtEntrenos,
        qtMedia: qtMedia ?? this.qtMedia,
        cdFunc: cdFunc ?? this.cdFunc,
        dtOperacao: dtOperacao ?? this.dtOperacao,
        hrOperacao: hrOperacao ?? this.hrOperacao,
        status: status ?? this.status,
        dtStatus: dtStatus ?? this.dtStatus,
        dispositivo: dispositivo ?? this.dispositivo,
      );

  factory ApontBrocaModel.fromJson(Map<String, dynamic> json) =>
      ApontBrocaModel(
        noColetor: json['noColetor'],
        instancia: json['instancia'],
        noBoletim: json['noBoletim'],
        cdFitoss: json['cdFitoss'],
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
        dispositivo: json['dispositivo'],
      );

  factory ApontBrocaModel.fromUpnivel3(
    UpNivel3Model upnivel, {
    @required int noBoletin,
    @required int noSequencia,
    @required int dispositivo,
    @required int cdFunc,
  }) =>
      ApontBrocaModel(
        dispositivo: dispositivo,
        cdFunc: cdFunc,
        cdSafra: upnivel.cdSafra,
        cdUpnivel1: upnivel.cdUpnivel1,
        cdUpnivel2: upnivel.cdUpnivel2,
        cdUpnivel3: upnivel.cdUpnivel3,
        cdFitoss: null,
        dtOperacao: Moment.now().format('yyyy-MM-dd'),
        dtStatus: Moment.now().format('yyyy-MM-dd'),
        hrOperacao: Moment.now().format('yyyy-MM-dd HH:mm:ss'),
        // TODO: Remover o mock namar
        instancia: upnivel.instancia ?? 'NAMAR',
        noBoletim: noBoletin,
        noColetor: dispositivo,
        noSequencia: noSequencia,
        qtBrocados: 0,
        qtEntrenos: 0,
        qtCanaPodr: 0,
        qtCanas: 0,
        qtCanasbroc: 0,
        qtEntrPodr: 0,
        qtMedia: 0,
        status: 'P',
        versao: null,
      );

  Map<String, dynamic> get toJson => {
        'noColetor': noColetor,
        'instancia': instancia,
        'noBoletim': noBoletim,
        'noSequencia': noSequencia,
        'cdFitoss': cdFitoss,
        'versao': versao,
        'cdSafra': cdSafra,
        'cdUpnivel1': cdUpnivel1,
        'cdUpnivel2': cdUpnivel2,
        'cdUpnivel3': cdUpnivel3,
        'qtBrocados': qtBrocados,
        'qtCanaPodr': qtCanaPodr,
        'qtCanas': qtCanas,
        'qtCanasbroc': qtCanasbroc,
        'qtEntrPodr': qtEntrPodr,
        'qtEntrenos': qtEntrenos,
        'qtMedia': qtMedia,
        'cdFunc': cdFunc,
        'dtOperacao': dtOperacao,
        'hrOperacao': hrOperacao,
        'status': status,
        'dtStatus': dtStatus,
        'dispositivo': dispositivo,
      };

  @override
  List<Object> get props => [
        noColetor,
        instancia,
        noBoletim,
        noSequencia,
        cdFitoss,
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
        dispositivo,
      ];
}
