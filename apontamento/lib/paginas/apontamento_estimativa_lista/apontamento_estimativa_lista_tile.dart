import 'package:apontamento/comum/componentes/monta_linha.dart';
import 'package:apontamento/comum/modelo/estimativa_modelo.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/monta_tabela.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

class ApontamentoEstimativaListaTile extends StatelessWidget {
  final bool selected;
  final Function(bool) onSelectionChange;
  final EstimativaModelo estimativa;

  ApontamentoEstimativaListaTile({
    @required this.onSelectionChange,
    @required this.estimativa,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        trailing: Container(width: 1, height: 1),
        tilePadding: EdgeInsets.only(left: 8, right: 0),
        leading: Checkbox(value: selected, onChanged: onSelectionChange),
        title: MontaTabela(
          estimativa: estimativa,
        ),
        childrenPadding: EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table(
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    'Dados',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Table(
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Tch0'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  child: Text(
                                    estimativa.tch0 != null
                                        ? estimativa.tch0
                                            .toStringAsFixed(2)
                                            .replaceFirst('.', ',')
                                        : '',
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Tch1'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  child: Text(
                                    estimativa.tch1 != null
                                        ? estimativa.tch1
                                            .toStringAsFixed(2)
                                            .replaceFirst('.', ',')
                                        : '',
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Tch2'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Text(
                                    estimativa.tch2 != null
                                        ? estimativa.tch2
                                            .toStringAsFixed(2)
                                            .replaceFirst('.', ',')
                                        : '',
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Tch3'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Text(
                                    estimativa.tch3 != null
                                        ? estimativa.tch3
                                            .toStringAsFixed(2)
                                            .replaceFirst('.', ',')
                                        : '',
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Tch4'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Text(
                                    estimativa.tch4 != null
                                        ? estimativa.tch4
                                            .toStringAsFixed(2)
                                            .replaceFirst('.', ',')
                                        : '',
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                                bottom:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Table(
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    'Informações',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Table(
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Data'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  child: Text(
                                    Moment.parse(estimativa.dtHistorico)
                                        .format('dd/MM/yyyy'),
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('TpProp'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  child: Text(estimativa.deTpPropr ?? ''),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Estagio'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Text(estimativa.deEstagio ?? ''),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Variedade'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Text(estimativa.deVaried ?? ''),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Ult. Corte'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Text(
                                    Moment.parse(estimativa.dtUltimoCorte)
                                        .format('dd/MM/yyyy'),
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Precipitação'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Text(
                                    estimativa.precipitacao
                                        .toStringAsFixed(2)
                                        .replaceFirst('.', ','),
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Área Produzida'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Text(
                                    estimativa.qtAreaProd
                                        .toStringAsFixed(2)
                                        .replaceFirst('.', ','),
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Produção Anterior'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Text(
                                    estimativa.producaoSafraAnt
                                        .toStringAsFixed(2)
                                        .replaceFirst('.', ','),
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Sphenophous'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Text(
                                    estimativa.sphenophous
                                        .toStringAsFixed(2)
                                        .replaceFirst('.', ','),
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Tch Ano Passado'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Text(
                                    estimativa.tchAnoPassado
                                        .toStringAsFixed(2)
                                        .replaceFirst('.', ','),
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  child: Text('Tch Ano Retrasado'),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.black12, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  child: Text(estimativa.tchAnoRetrasado
                                      .toStringAsFixed(2)
                                      .replaceFirst('.', ',')),
                                  padding: EdgeInsets.all(12),
                                ),
                              ),
                            ],
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(color: Colors.black12, width: 1),
                                right:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                                bottom:
                                    BorderSide(color: Colors.black12, width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  ['P', 'E'].contains(estimativa.status)
                      ? Icon(
                          Icons.backup,
                          color: Colors.yellow,
                          size: 48,
                        )
                      : Container(),
                  estimativa.status == 'E'
                      ? Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 48,
                        )
                      : Container(),
                  estimativa.status == 'I'
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 48,
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 1),
        ),
      ),
    );
  }
}
