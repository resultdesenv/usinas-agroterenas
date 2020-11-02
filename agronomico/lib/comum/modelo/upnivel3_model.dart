import 'package:agronomico/comum/modelo/estimativa_modelo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:simple_moment/simple_moment.dart';

class UpNivel3Model extends Equatable {
  final int cdEstagio;
  final int cdSafra;
  final int cdTpPropr;
  final String cdUpnivel1;
  final String cdUpnivel2;
  final String cdUpnivel3;
  final int cdVaried;
  final String deEstagio;
  final String deTpPropr;
  final String deVaried;
  final String dtUltimoCorte;
  final String instancia;
  final double precipitacao;
  final double qtAreaProd;
  final double producaoSafraAnt;
  final double sphenophous;
  final double tch0;
  final double tch1;
  final double tch2;
  final double tch3;
  final double tch4;
  final double tchAnoPassado;
  final double tchAnoRetrasado;

  List<Object> get props => [
        cdEstagio,
        cdSafra,
        cdTpPropr,
        cdUpnivel1,
        cdUpnivel2,
        cdUpnivel3,
        cdVaried,
        deEstagio,
        deTpPropr,
        deVaried,
        dtUltimoCorte,
        instancia,
        precipitacao,
        qtAreaProd,
        producaoSafraAnt,
        sphenophous,
        tch0,
        tch1,
        tch2,
        tch3,
        tch4,
        tchAnoPassado,
        tchAnoRetrasado,
      ];

  UpNivel3Model({
    @required this.cdEstagio,
    @required this.cdSafra,
    @required this.cdTpPropr,
    @required this.cdUpnivel1,
    @required this.cdUpnivel2,
    @required this.cdUpnivel3,
    @required this.cdVaried,
    @required this.deEstagio,
    @required this.deTpPropr,
    @required this.deVaried,
    @required this.dtUltimoCorte,
    @required this.instancia,
    @required this.precipitacao,
    @required this.qtAreaProd,
    @required this.producaoSafraAnt,
    @required this.sphenophous,
    @required this.tch0,
    @required this.tch1,
    @required this.tch2,
    @required this.tch3,
    @required this.tch4,
    @required this.tchAnoPassado,
    @required this.tchAnoRetrasado,
  });

  factory UpNivel3Model.fromJson(Map<String, dynamic> json) {
    return UpNivel3Model(
      cdEstagio: int.tryParse(json['cdEstagio']?.toString()),
      cdSafra: int.tryParse(json['cdSafra']?.toString()),
      cdTpPropr: int.tryParse(json['cdTpPropr']?.toString()),
      cdUpnivel1: json['cdUpnivel1'],
      cdUpnivel2: json['cdUpnivel2'],
      cdUpnivel3: json['cdUpnivel3'],
      cdVaried: int.tryParse(json['cdVaried']?.toString()),
      deEstagio: json['deEstagio'],
      deTpPropr: json['deTpPropr'],
      deVaried: json['deVaried'],
      dtUltimoCorte: json['dtUltimoCorte'],
      instancia: json['instancia'],
      precipitacao: double.tryParse(json['precipitacao']?.toString()),
      qtAreaProd: double.tryParse((json['qtAreaProd'] ?? '')?.toString()),
      producaoSafraAnt:
          double.tryParse((json['producaoSafraAnt'] ?? '')?.toString()),
      sphenophous: double.tryParse((json['sphenophous'] ?? '')?.toString()),
      tch0: double.tryParse((json['tch0'] ?? '')?.toString()),
      tch1: double.tryParse((json['tch1'] ?? '')?.toString()),
      tch2: double.tryParse((json['tch2'] ?? '')?.toString()),
      tch3: double.tryParse((json['tch3'] ?? '')?.toString()),
      tch4: double.tryParse((json['tch4'] ?? '')?.toString()),
      tchAnoPassado: double.tryParse((json['tchAnoPassado'] ?? '')?.toString()),
      tchAnoRetrasado:
          double.tryParse((json['tchAnoRetrasado'] ?? '')?.toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        'cdEstagio': cdEstagio,
        'cdSafra': cdSafra,
        'cdTpPropr': cdTpPropr,
        'cdUpnivel1': cdUpnivel1,
        'cdUpnivel2': cdUpnivel2,
        'cdUpnivel3': cdUpnivel3,
        'cdVaried': cdVaried,
        'deEstagio': deEstagio,
        'deTpPropr': deTpPropr,
        'deVaried': deVaried,
        'dtUltimoCorte': dtUltimoCorte,
        'instancia': instancia,
        'precipitacao': precipitacao,
        'qtAreaProd': qtAreaProd,
        'producaoSafraAnt': producaoSafraAnt,
        'sphenophous': sphenophous,
        'tch0': tch0,
        'tch1': tch1,
        'tch2': tch2,
        'tch3': tch3,
        'tch4': tch4,
        'tchAnoPassado': tchAnoPassado,
        'tchAnoRetrasado': tchAnoRetrasado,
      };

  EstimativaModelo gerarEstimativa({
    @required int cdFunc,
    @required int noBoletim,
    @required int noSeq,
    @required int dispositivo,
  }) =>
      EstimativaModelo(
        cdEstagio: cdEstagio,
        deEstagio: deEstagio,
        cdSafra: cdSafra,
        cdTpPropr: cdTpPropr,
        deTpPropr: deTpPropr,
        cdUpnivel1: cdUpnivel1,
        cdUpnivel2: cdUpnivel2,
        cdUpnivel3: cdUpnivel3,
        cdVaried: cdVaried,
        deVaried: deVaried,
        dtUltimoCorte: dtUltimoCorte,
        instancia: instancia,
        precipitacao: precipitacao,
        qtAreaProd: qtAreaProd,
        producaoSafraAnt: producaoSafraAnt,
        sphenophous: sphenophous,
        tch0: tch0,
        tch1: tch1,
        tch2: tch2,
        tch3: tch3,
        tch4: tch4,
        cdFunc: cdFunc,
        noBoletim: noBoletim,
        noSeq: noSeq,
        dispositivo: dispositivo,
        dtHistorico: Moment.now().format('yyyy-MM-dd'),
        tchAnoPassado: tchAnoPassado,
        tchAnoRetrasado: tchAnoRetrasado,
        dtStatus: Moment.now().format('yyyy-MM-dd'),
      );
}
