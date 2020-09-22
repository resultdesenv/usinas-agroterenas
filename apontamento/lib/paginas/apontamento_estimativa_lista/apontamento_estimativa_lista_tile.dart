import 'package:apontamento/comun/componentes/monta_linha.dart';
import 'package:apontamento/comun/modelo/estimativa_modelo.dart';
import 'package:apontamento/paginas/apontamento_estimativa_lista/monta_tabela.dart';
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
    return ExpansionTile(
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
                    Text(
                      'Dados',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    MontaLinha(
                        label: 'Tech0',
                        valor: estimativa.tch0 != null
                            ? estimativa.tch0.toString()
                            : ''),
                    MontaLinha(
                        label: 'Tech1',
                        valor: estimativa.tch1 != null
                            ? estimativa.tch1.toString()
                            : ''),
                    MontaLinha(
                        label: 'Tech2',
                        valor: estimativa.tch2 != null
                            ? estimativa.tch2.toString()
                            : ''),
                    MontaLinha(
                        label: 'Tech3',
                        valor: estimativa.tch3 != null
                            ? estimativa.tch3.toString()
                            : ''),
                    MontaLinha(
                        label: 'Tech4',
                        valor: estimativa.tch4 != null
                            ? estimativa.tch4.toString()
                            : ''),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        'Informações',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    MontaLinha(
                        label: 'Data',
                        valor: Moment.parse(estimativa.dtHistorico)
                            .format('dd/MM/yyyy')),
                    MontaLinha(
                        label: 'TpProp',
                        valor: estimativa.cdTpPropr.toString()),
                    MontaLinha(
                        label: 'Estagio',
                        valor: estimativa.cdEstagio.toString()),
                    MontaLinha(
                        label: 'Variedade',
                        valor: estimativa.cdVaried.toString()),
                    MontaLinha(
                        label: 'Ult. Corte',
                        valor: Moment.parse(estimativa.dtUltimoCorte)
                            .format('dd/MM/yyyy')),
                    MontaLinha(
                        label: 'Precipitação',
                        valor: estimativa.precipitacao.toString()),
                    MontaLinha(
                        label: 'Área Produzida',
                        valor: estimativa.qtAreaProd.toString()),
                    MontaLinha(
                        label: 'Produção Anterior',
                        valor: estimativa.producaoSafraAnt.toString()),
                    MontaLinha(
                        label: 'Sphenophous',
                        valor: estimativa.sphenophous.toString()),
                    MontaLinha(
                        label: 'Tech Ano Passado',
                        valor: estimativa.tchAnoPassado.toString()),
                    MontaLinha(
                        label: 'Tech Ano Retrasado',
                        valor: Moment.parse(estimativa.dtHistorico)
                            .format('dd/MM/yyyy')),
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
    );
  }
}
