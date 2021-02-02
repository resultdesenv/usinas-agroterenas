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
  final controllerTotal;
  final controllerBrocados;

  ApontamentoBrocaFormItem({
    @required this.broca,
    this.indiceBroca,
    this.onChanged,
    @required this.controllerTotal,
    @required this.controllerBrocados,
  });

  @override
  Widget build(BuildContext context) {
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

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Text(
              'Cana ${broca.noSequencia}',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: controllerTotal,
                focusNode: focusTotal,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Total'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d]'))
                ],
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
                  FilteringTextInputFormatter.allow(RegExp(r'[\d]')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ApontBrocaModel get valores => broca.juntar(
        qtBrocados: double.tryParse(controllerBrocados.text) ?? 0,
        qtEntrenos: double.tryParse(controllerTotal.text) ?? 0,
      );
}
