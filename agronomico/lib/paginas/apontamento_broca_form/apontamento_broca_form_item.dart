import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ApontamentoBrocaFormItem extends StatelessWidget {
  final ApontBrocaModel broca;
  final int indiceBroca;
  final Function(ApontBrocaModel) onChanged;
  final focusTotal = FocusNode();
  final focusBrocados = FocusNode();

  ApontamentoBrocaFormItem({
    @required this.broca,
    @required this.indiceBroca,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controllerTotal =
        TextEditingController(text: broca.qtEntrenos.toString());
    final controllerBrocados =
        TextEditingController(text: broca.qtBrocados.toString());

    focusTotal.addListener(() {
      controllerTotal.selection = TextSelection(
        baseOffset: 0,
        extentOffset: controllerTotal.value.text.length,
      );
    });
    focusBrocados.addListener(() {
      controllerBrocados.selection = TextSelection(
        baseOffset: 0,
        extentOffset: controllerBrocados.value.text.length,
      );
    });

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cana ${broca.noSequencia}',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controllerTotal,
                    focusNode: focusTotal,
                    textInputAction: TextInputAction.next,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(labelText: 'Total'),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))
                    ],
                    onChanged: (value) => onChanged(
                      broca.juntar(
                          qtEntrenos:
                              double.tryParse(value) ?? broca.qtEntrenos),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: controllerBrocados,
                    focusNode: focusBrocados,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Brocados'),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))
                    ],
                    onChanged: (value) => onChanged(
                      broca.juntar(
                          qtBrocados:
                              double.tryParse(value) ?? broca.qtBrocados),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
