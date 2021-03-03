import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ApontamentoBrocaFormItem extends StatelessWidget {
  final ApontBrocaModel broca;
  final int totalBrocas;
  final Function(ApontBrocaModel, bool) onChanged;
  final Function(DismissDirection) onDissmissed;
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
    @required this.onDissmissed,
    @required this.totalBrocas,
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

    return Dismissible(
      child: Container(
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
                  onChanged: (value) => _onChanged(context, value, false),
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
                  onChanged: (value) => _onChanged(context, value, true),
                  inputFormatters: inputFormatters,
                ),
              ),
            ],
          ),
        ),
      ),
      onDismissed: onDissmissed,
      confirmDismiss: (_) => _confirmaRemocao(context),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ],
        ),
      ),
      direction: DismissDirection.startToEnd,
      key: ValueKey(broca.noSequencia.toString()),
    );
  }

  ApontBrocaModel get valores => broca.juntar(
        qtBrocados: double.tryParse(controllerBrocados.text) ?? 0,
        qtEntrenos: double.tryParse(controllerTotal.text) ?? 0,
      );

  void _onChanged(BuildContext context, String value, bool geraBroca) {
    if (value.length == 2) {
      if (onChanged != null) onChanged(valores, geraBroca);
      FocusScope.of(context).nextFocus();
    }
  }

  Future<bool> _confirmaRemocao(BuildContext context) async =>
      totalBrocas > 1 &&
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Deseja remover?'),
          content: Text(
              'Ao confirma essa ação você estará removendo a Cana ${broca.noSequencia}'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancelar'),
            ),
            FlatButton(
              textColor: Colors.red,
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Confirmar'),
            ),
          ],
        ),
      );
}
