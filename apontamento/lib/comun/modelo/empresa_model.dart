import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class EmpresaModel extends Equatable {
  final int cdEmpresa;
  final String cdInstManfro;
  final String daEmpresa;
  final String deEmpresa;

  List<Object> get props => [
        cdEmpresa,
        cdInstManfro,
        daEmpresa,
        deEmpresa,
      ];

  EmpresaModel({
    @required this.cdEmpresa,
    @required this.cdInstManfro,
    @required this.daEmpresa,
    @required this.deEmpresa,
  });

  factory EmpresaModel.fromJson(Map<String, dynamic> json) => EmpresaModel(
      cdEmpresa: int.tryParse(json['cdEmpresa'].toString()),
      cdInstManfro: json['cdInstManfro'].toString(),
      daEmpresa: json['daEmpresa'].toString(),
      deEmpresa: json['deEmpresa'].toString());

  Map<String, dynamic> toJson() => {
        'cdEmpresa': cdEmpresa,
        'cdInstManfro': cdInstManfro,
        'daEmpresa': daEmpresa,
        'deEmpresa': deEmpresa,
      };
}
