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
  final inputFormatters = [
    FilteringTextInputFormatter.allow(RegExp(r'[\d]')),
    LengthLimitingTextInputFormatter(2),
    TextInputFormatter.withFunction((_, novo) {
      print(novo.text);
      return TextEditingValue(
        text: novo.text.isEmpty
            ? ''
            : int.tryParse(novo.text) > 50
                ? '50'
                : novo.text,
        selection: TextSelection.collapsed(offset: novo.text.length),
      );
    }),
  ];

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
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black38)),
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
                onChanged: (value) => _onChanged(context, value),
                inputFormatters: inputFormatters,
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
                onChanged: (value) => _onChanged(context, value),
                inputFormatters: inputFormatters,
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

  void _onChanged(BuildContext context, String value) {
    if (value.length == 2) FocusScope.of(context).nextFocus();
  }
}
