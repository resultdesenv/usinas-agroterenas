import 'package:apontamento/comun/modelo/sequencia_model.dart';
import 'package:flutter/material.dart';

class ConfiguracaoSequencias extends StatelessWidget {
  final List<Sequencia> sequencias;

  ConfiguracaoSequencias({@required this.sequencias});

  @override
  Widget build(BuildContext context) {
    return sequencias.length > 0
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1)),
                child: DataTable(
                    columns: [
                      DataColumn(label: Text('Aplicação')),
                      DataColumn(label: Text('Instancia')),
                      DataColumn(label: Text('Sequencia'))
                    ],
                    rows: sequencias
                        .map((sequencia) => DataRow(cells: [
                              DataCell(Text(sequencia.aplicacao)),
                              DataCell(Text(sequencia.instancia)),
                              DataCell(Text(sequencia.sequencia.toString()))
                            ]))
                        .toList())))
        : Container();
  }
}
