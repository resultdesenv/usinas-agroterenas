import 'package:apontamento/comum/modelo/upnivel3_model.dart';
import 'package:flutter/material.dart';

class UpNivel3MontaTabela extends StatelessWidget {
  final UpNivel3Model upnivel3;

  UpNivel3MontaTabela({@required this.upnivel3});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            TableCell(
              child: Text(
                upnivel3.cdSafra.toString(),
                style: TextStyle(fontSize: 10),
              ),
            ),
            TableCell(
              child: Text(
                upnivel3.cdUpnivel1.replaceAll(' ', '0'),
                style: TextStyle(fontSize: 10),
              ),
            ),
            TableCell(
              child: Text(
                upnivel3.cdUpnivel2.replaceAll(' ', '0'),
                style: TextStyle(fontSize: 10),
              ),
            ),
            TableCell(
              child: Text(
                upnivel3.cdUpnivel3.replaceAll(' ', '0'),
                style: TextStyle(fontSize: 10),
              ),
            ),
            TableCell(
              child: Text(
                upnivel3.qtAreaProd.toString(),
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
