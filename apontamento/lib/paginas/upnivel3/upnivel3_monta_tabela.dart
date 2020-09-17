import 'package:apontamento/comun/modelo/upnivel3_model.dart';
import 'package:flutter/material.dart';

class UpNivel3MontaTabela extends StatelessWidget {
  final UpNivel3Model upnivel3;

  UpNivel3MontaTabela({@required this.upnivel3});

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
                  child: Text('Area', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Text(upnivel3.cdSafra.toString()),
                ),
                TableCell(
                  child: Text(upnivel3.cdUpnivel1.replaceAll(' ', '0')),
                ),
                TableCell(
                  child: Text(upnivel3.cdUpnivel2.replaceAll(' ', '0')),
                ),
                TableCell(
                  child: Text(upnivel3.cdUpnivel3.replaceAll(' ', '0')),
                ),
                TableCell(
                  child: Text(upnivel3.qtAreaProd.toString()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
