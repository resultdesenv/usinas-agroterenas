import 'package:apontamento/comun/modelo/estimativa_modelo.dart';
import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

class MontaTabela extends StatelessWidget {
  final EstimativaModelo estimativa;

  MontaTabela({@required this.estimativa});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 480,
        child: Table(
          columnWidths: {6: FractionColumnWidth(0.18)},
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Text('Boletim', style: TextStyle(color: Colors.grey)),
                ),
                TableCell(
                  child: Text('Seq', style: TextStyle(color: Colors.grey)),
                ),
                TableCell(
                  child: Text('Safra', style: TextStyle(color: Colors.grey)),
                ),
                TableCell(
                  child: Text('Up1', style: TextStyle(color: Colors.grey)),
                ),
                TableCell(
                  child: Text('Up2', style: TextStyle(color: Colors.grey)),
                ),
                TableCell(
                  child: Text('Up3', style: TextStyle(color: Colors.grey)),
                ),
                TableCell(
                  child: Text('Data', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(child: Text(estimativa.noBoletim.toString())),
                TableCell(child: Text(estimativa.noSeq.toString())),
                TableCell(child: Text(estimativa.cdSafra.toString())),
                TableCell(
                    child: Text(estimativa.cdUpnivel1.replaceAll(' ', '0'))),
                TableCell(
                    child: Text(estimativa.cdUpnivel2.replaceAll(' ', '0'))),
                TableCell(
                    child: Text(estimativa.cdUpnivel3.replaceAll(' ', '0'))),
                TableCell(
                    child: Text(
                  Moment.parse(estimativa.dtHistorico).format('dd/MM/yyy'),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
