import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:flutter/material.dart';

class TalhaoUnicoMontaTabela extends StatelessWidget {
  final UpNivel3Model talhao;
  final bool disabled;

  TalhaoUnicoMontaTabela({
    @required this.talhao,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            TableCell(
              child: Text(
                talhao.cdSafra.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: disabled ? Colors.black38 : Colors.black,
                ),
              ),
            ),
            TableCell(
              child: Text(
                talhao.cdUpnivel2,
                style: TextStyle(
                  fontSize: 14,
                  color: disabled ? Colors.black38 : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
              child: Text(
                talhao.cdUpnivel3,
                style: TextStyle(
                  fontSize: 14,
                  color: disabled ? Colors.black38 : Colors.black,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            TableCell(
              child: Text(
                talhao.qtAreaProd.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: disabled ? Colors.black38 : Colors.black,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
