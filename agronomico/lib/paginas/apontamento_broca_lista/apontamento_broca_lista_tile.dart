import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:agronomico/paginas/apontamento_broca_lista/apontamento_broca_lista_monta_tabela.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      children: [
        Column(
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
          ],
        )
      ],
    );
  }
}
