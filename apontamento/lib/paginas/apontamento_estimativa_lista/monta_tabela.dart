import 'package:apontamento/comum/modelo/estimativa_modelo.dart';
import 'package:flutter/material.dart';

class MontaTabela extends StatelessWidget {
  final EstimativaModelo estimativa;

  MontaTabela({@required this.estimativa});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Table(
        children: [
          TableRow(
            children: [
              TableCell(
                child: Text(
                  estimativa.noBoletim.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              ),
              TableCell(
                child: Text(
                  estimativa.noSeq.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              ),
              TableCell(
                child: Text(
                  estimativa.cdSafra.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              ),
              TableCell(
                child: Text(
                  estimativa.cdUpnivel1.replaceAll(' ', '0'),
                  style: TextStyle(fontSize: 10),
                ),
              ),
              TableCell(
                child: Text(
                  estimativa.cdUpnivel2.replaceAll(' ', '0'),
                  style: TextStyle(fontSize: 10),
                ),
              ),
              TableCell(
                child: Text(
                  estimativa.cdUpnivel3.replaceAll(' ', '0'),
                  style: TextStyle(fontSize: 10),
                ),
              ),
              TableCell(
                  child: Container(
                height: 10,
                width: 10,
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    Positioned(
                      top: -12,
                      left: 8,
                      child: ['P', 'E'].contains(estimativa.status)
                          ? Icon(
                              Icons.backup,
                              color: Colors.yellow,
                              size: 32,
                            )
                          : estimativa.status == 'E'
                              ? Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 32,
                                )
                              : estimativa.status == 'I'
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 32,
                                    )
                                  : Container(),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
