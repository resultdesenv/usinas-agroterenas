import 'package:apontamento/comum/componentes/monta_linha.dart';
import 'package:apontamento/comum/modelo/upnivel3_model.dart';
import 'package:apontamento/paginas/upnivel3/upnivel3_monta_tabela.dart';
import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

class UpNivel3Tile extends StatelessWidget {
  final bool selected;
  final Function(bool) onSelectionChange;
  final UpNivel3Model upnivel3;
  final bool selecaoMultipla;

  UpNivel3Tile({
    @required this.onSelectionChange,
    @required this.upnivel3,
    @required this.selecaoMultipla,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        leading: selecaoMultipla
            ? Checkbox(value: selected, onChanged: onSelectionChange)
            : null,
        title: UpNivel3MontaTabela(upnivel3: upnivel3),
        tilePadding: EdgeInsets.only(left: 8, right: 0),
        trailing: Container(width: 1, height: 1),
        childrenPadding: EdgeInsets.all(16),
        children: [
          Column(
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
                            'Detalhes',
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
                        top: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          child: Text(
                            upnivel3.tch0 != null
                                ? upnivel3.tch0
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
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          child: Text(
                            upnivel3.tch1 != null
                                ? upnivel3.tch1
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
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text(
                            upnivel3.tch2 != null
                                ? upnivel3.tch2
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
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text(
                            upnivel3.tch3 != null
                                ? upnivel3.tch3
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
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text(
                            upnivel3.tch4 != null
                                ? upnivel3.tch4
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
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text(upnivel3.deTpPropr),
                          padding: EdgeInsets.all(12),
                        ),
                      ),
                    ],
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text(upnivel3.deEstagio),
                          padding: EdgeInsets.all(12),
                        ),
                      ),
                    ],
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text(upnivel3.deVaried),
                          padding: EdgeInsets.all(12),
                        ),
                      ),
                    ],
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text(upnivel3.dtUltimoCorte != null
                              ? Moment.parse(upnivel3.dtUltimoCorte)
                                  .format('dd/MM/yyyy')
                              : ''),
                          padding: EdgeInsets.all(12),
                        ),
                      ),
                    ],
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text(upnivel3.precipitacao != null
                              ? upnivel3.precipitacao
                                  .toStringAsFixed(2)
                                  .replaceFirst('.', ',')
                              : ''),
                          padding: EdgeInsets.all(12),
                        ),
                      ),
                    ],
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text(upnivel3.qtAreaProd != null
                              ? upnivel3.qtAreaProd
                                  .toStringAsFixed(2)
                                  .replaceFirst('.', ',')
                              : ''),
                          padding: EdgeInsets.all(12),
                        ),
                      ),
                    ],
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text(upnivel3.producaoSafraAnt != null
                              ? upnivel3.producaoSafraAnt
                                  .toStringAsFixed(2)
                                  .replaceFirst('.', ',')
                              : ''),
                          padding: EdgeInsets.all(12),
                        ),
                      ),
                    ],
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text(upnivel3.sphenophous != null
                              ? upnivel3.sphenophous
                                  .toStringAsFixed(2)
                                  .replaceFirst('.', ',')
                              : ''),
                          padding: EdgeInsets.all(12),
                        ),
                      ),
                    ],
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text(upnivel3.tchAnoPassado != null
                              ? upnivel3.tchAnoPassado
                                  .toStringAsFixed(2)
                                  .replaceFirst('.', ',')
                              : ''),
                          padding: EdgeInsets.all(12),
                        ),
                      ),
                    ],
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
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
                              right:
                                  BorderSide(color: Colors.black12, width: 1),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Text(upnivel3.tchAnoRetrasado != null
                              ? upnivel3.tchAnoRetrasado
                                  .toStringAsFixed(2)
                                  .replaceFirst('.', ',')
                              : ''),
                          padding: EdgeInsets.all(12),
                        ),
                      ),
                    ],
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black12, width: 1),
                        right: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
                        bottom: BorderSide(color: Colors.black12, width: 1),
                      ),
                    ),
                  ),
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
