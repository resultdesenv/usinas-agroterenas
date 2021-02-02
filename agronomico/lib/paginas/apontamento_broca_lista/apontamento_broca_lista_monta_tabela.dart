import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ApontamentoBrocaListaMontaTabela extends StatelessWidget {
  final ApontBrocaModel broca;

  ApontamentoBrocaListaMontaTabela({@required this.broca});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Table(
        children: [
          TableRow(
            children: [
              TableCell(
                child: Text(
                  broca.noBoletim.toString(),
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.end,
                ),
              ),
              TableCell(
                child: Text(
                  broca.noColetor.toString(),
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.end,
                ),
              ),
              TableCell(
                child: Text(
                  broca.cdSafra.toString(),
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.end,
                ),
              ),
              TableCell(
                child: Text(
                  broca.cdUpnivel1,
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.end,
                ),
              ),
              TableCell(
                child: Text(
                  broca.cdUpnivel2,
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.end,
                ),
              ),
              TableCell(
                child: Text(
                  broca.cdUpnivel3,
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.end,
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
                      child: ['P', 'E'].contains(broca.status)
                          ? Icon(
                              Icons.backup,
                              color: Colors.yellow,
                              size: 32,
                            )
                          : broca.status == 'E'
                              ? Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 32,
                                )
                              : broca.status == 'I'
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
