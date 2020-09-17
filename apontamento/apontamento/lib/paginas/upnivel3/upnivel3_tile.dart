import 'package:apontamento/comun/componentes/monta_linha.dart';
import 'package:apontamento/comun/modelo/upnivel3_model.dart';
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
    return ExpansionTile(
      leading: selecaoMultipla
          ? Checkbox(value: selected, onChanged: onSelectionChange)
          : null,
      title: UpNivel3MontaTabela(
        upnivel3: upnivel3,
      ),
      childrenPadding: EdgeInsets.all(16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalhes',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            MontaLinha(
                label: 'Tech0',
                valor: upnivel3.tch0 != null ? upnivel3.tch0.toString() : ''),
            MontaLinha(
                label: 'Tech1',
                valor: upnivel3.tch1 != null ? upnivel3.tch1.toString() : ''),
            MontaLinha(
                label: 'Tech2',
                valor: upnivel3.tch2 != null ? upnivel3.tch2.toString() : ''),
            MontaLinha(
                label: 'Tech3',
                valor: upnivel3.tch3 != null ? upnivel3.tch3.toString() : ''),
            MontaLinha(
                label: 'Tech4',
                valor: upnivel3.tch4 != null ? upnivel3.tch4.toString() : ''),
            MontaLinha(label: 'TpProp', valor: upnivel3.cdTpPropr.toString()),
            MontaLinha(label: 'Estagio', valor: upnivel3.cdEstagio.toString()),
            MontaLinha(label: 'Variedade', valor: upnivel3.cdVaried.toString()),
            MontaLinha(
              label: 'Ult. Corte',
              valor: upnivel3.dtUltimoCorte != null
                  ? Moment.parse(upnivel3.dtUltimoCorte).format('dd/MM/yyyy')
                  : null,
            ),
            MontaLinha(
                label: 'Precipitação', valor: upnivel3.precipitacao.toString()),
            MontaLinha(
                label: 'Área Produzida', valor: upnivel3.qtAreaProd.toString()),
            MontaLinha(
                label: 'Produção Anterior',
                valor: upnivel3.producaoSafraAnt.toString()),
            MontaLinha(
                label: 'Sphenophous',
                valor: upnivel3.sphenophous != null
                    ? upnivel3.sphenophous.toString()
                    : ''),
            MontaLinha(
                label: 'Tech Ano Passado',
                valor: upnivel3.tchAnoPassado.toString()),
            MontaLinha(
                label: 'Tech Ano Retrasado',
                valor: upnivel3.tchAnoRetrasado.toString()),
          ],
        ),
      ],
    );
  }
}
