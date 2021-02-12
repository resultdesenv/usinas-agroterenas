import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:agronomico/paginas/talhao_unico/talhao_unico_monta_tabela.dart';
import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

class TalhaoUnicoTile extends StatelessWidget {
  final UpNivel3Model talhao;
  final Function(UpNivel3Model talhao) onPressed;

  TalhaoUnicoTile({
    @required this.talhao,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        title: TalhaoUnicoMontaTabela(
          talhao: talhao,
        ),
        trailing: FloatingActionButton(
          heroTag: 'buton-${talhao.props}',
          child: Icon(
            Icons.add_circle,
            size: 32,
          ),
          onPressed: () => onPressed(talhao),
        ),
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
                            talhao.tch0 != null
                                ? talhao.tch0
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
                            talhao.tch1 != null
                                ? talhao.tch1
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
                            talhao.tch2 != null
                                ? talhao.tch2
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
                            talhao.tch3 != null
                                ? talhao.tch3
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
                            talhao.tch4 != null
                                ? talhao.tch4
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
                          child: Text(talhao.deTpPropr ?? ''),
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
                          child: Text(talhao.deEstagio),
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
                          child: Text(talhao.deVaried),
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
                          child: Text('Ult.Corte'),
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
                          child: Text(talhao.dtUltimoCorte != null
                              ? Moment.parse(talhao.dtUltimoCorte)
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
                          child: Text(talhao.precipitacao != null
                              ? talhao.precipitacao
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
                          child: Text(talhao.qtAreaProd != null
                              ? talhao.qtAreaProd
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
                          child: Text(talhao.producaoSafraAnt != null
                              ? talhao.producaoSafraAnt
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
                          child: Text(talhao.sphenophous != null
                              ? talhao.sphenophous
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
                          child: Text(talhao.tchAnoPassado != null
                              ? talhao.tchAnoPassado
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
                          child: Text(talhao.tchAnoRetrasado != null
                              ? talhao.tchAnoRetrasado
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
    );
  }
}
