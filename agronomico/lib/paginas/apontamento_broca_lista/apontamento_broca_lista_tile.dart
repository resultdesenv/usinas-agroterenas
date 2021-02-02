import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_monta_tabela.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_moment/simple_moment.dart';

class ApontamentoBrocaListaTile extends StatelessWidget {
  final ApontBrocaModel broca;
  final bool selecionado;
  final Function(bool) alteraSelecao;

  ApontamentoBrocaListaTile({
    @required this.broca,
    @required this.alteraSelecao,
    this.selecionado = false,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Checkbox(
        value: selecionado,
        onChanged: alteraSelecao,
      ),
      title: ApontamentoBrocaListaMontaTabela(broca: broca),
      childrenPadding: EdgeInsets.all(16),
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
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
                        child: Text(
                          'Qt. Canas',
                        ),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.black12, width: 1),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        child: Text(
                          broca.qtCanas.toInt().toString(),
                          textAlign: TextAlign.right,
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
                        child: Text(
                          'Qt. Etrenos',
                        ),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.black12, width: 1),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        child: Text(
                          broca.qtEntrenos.toInt().toString(),
                          textAlign: TextAlign.right,
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
                        child: Text(
                          'Qt. Brocados',
                        ),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.black12, width: 1),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        child: Text(
                          broca.qtBrocados.toInt().toString(),
                          textAlign: TextAlign.right,
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
                        child: Text(
                          'Qt. Canas Brocadas',
                        ),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.black12, width: 1),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        child: Text(
                          broca.qtCanasbroc.toInt().toString(),
                          textAlign: TextAlign.right,
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
                        child: Text(
                          'Dt. Operacao',
                        ),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.black12, width: 1),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        child: Text(
                          Moment.parse(broca.dtOperacao).format('dd/MM/yyyy'),
                          textAlign: TextAlign.right,
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
                        child: Text(
                          'Hr. Operacao',
                        ),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.black12, width: 1),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        child: Text(
                          Moment.parse(broca.hrOperacao).format('HH:mm'),
                          textAlign: TextAlign.right,
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
                      bottom: BorderSide(color: Colors.black12, width: 1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
