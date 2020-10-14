import 'package:apontamento/comum/modelo/estimativa_modelo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_moment/simple_moment.dart';

class ApontamentoFormulario extends StatelessWidget {
  final EstimativaModelo apontamento;
  final TextEditingController controllerTch0;
  final TextEditingController controllerTch1;
  final TextEditingController controllerTch2;
  final TextEditingController controllerTch3;
  final TextEditingController controllerTch4;

  ApontamentoFormulario({
    @required this.apontamento,
    @required this.controllerTch0,
    @required this.controllerTch1,
    @required this.controllerTch2,
    @required this.controllerTch3,
    @required this.controllerTch4,
  });

  @override
  Widget build(BuildContext context) {
    print(controllerTch0.text);
    print(controllerTch1.text);
    print(controllerTch2.text);
    print(controllerTch3.text);
    print(controllerTch4.text);

    return Card(
      margin: EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Boletim',
                      initialValue: apontamento.noBoletim,
                      enabled: false,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Sequencia',
                      initialValue: apontamento.noSeq,
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Safra',
                      initialValue: apontamento.cdSafra,
                      enabled: false,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Expanded(
                    child: _montaCampo(
                      labelText: 'UpNivel1',
                      initialValue: apontamento.cdUpnivel1.replaceAll(' ', '0'),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      labelText: 'UpNivel2',
                      initialValue: apontamento.cdUpnivel2.replaceAll(' ', '0'),
                      enabled: false,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Expanded(
                    child: _montaCampo(
                      labelText: 'UpNivel3',
                      initialValue: apontamento.cdUpnivel3.replaceAll(' ', '0'),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Divider(),
              ),
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      labelText: 'Tch0',
                      controller: controllerTch0,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Expanded(
                    child: _montaCampo(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      labelText: 'Tch1',
                      controller: controllerTch1,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      labelText: 'Tch2',
                      controller: controllerTch2,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Expanded(
                    child: _montaCampo(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      labelText: 'Tch3',
                      controller: controllerTch3,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      labelText: 'Tch4',
                      controller: controllerTch4,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Spacer(flex: 1),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Divider(),
              ),
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      labelText: 'TpProp',
                      initialValue: apontamento.deTpPropr,
                      enabled: false,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Estagio',
                      initialValue: apontamento.deEstagio,
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Variedade',
                      initialValue: apontamento.deVaried,
                      enabled: false,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Ult. Compra',
                      initialValue: Moment.parse(apontamento.dtUltimoCorte)
                          .format('dd/MM/yyyy'),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Precip',
                      initialValue: apontamento.precipitacao
                          .toStringAsFixed(2)
                          .replaceFirst('.', ','),
                      enabled: false,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Área Prod',
                      initialValue: apontamento.qtAreaProd
                          .toStringAsFixed(2)
                          .replaceFirst('.', ','),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Prod Ant',
                      initialValue: apontamento.producaoSafraAnt
                          .toStringAsFixed(2)
                          .replaceFirst('.', ','),
                      enabled: false,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Sphenoph',
                      initialValue: apontamento.sphenophous,
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Tch Ano Passado',
                      initialValue: apontamento.tchAnoPassado
                          .toStringAsFixed(2)
                          .replaceFirst('.', ','),
                      enabled: false,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Tch Ano Retrasado',
                      enabled: false,
                      initialValue: apontamento.tchAnoRetrasado
                          .toStringAsFixed(2)
                          .replaceFirst('.', ','),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _montaCampo({
    @required String labelText,
    dynamic initialValue,
    TextEditingController controller,
    bool enabled = true,
    Function(String) onChange,
    TextInputType keyboardType,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      initialValue: initialValue != null ? initialValue.toString() : null,
      enabled: enabled,
      onChanged: onChange,
      keyboardType: keyboardType,
      controller: controller,
    );
  }

  EstimativaModelo get valores => apontamento.copiarCom(
      tch0: controllerTch0.text.isNotEmpty
          ? double.parse(controllerTch0.text)
          : null,
      tch1: controllerTch1.text.isNotEmpty
          ? double.parse(controllerTch1.text)
          : null,
      tch2: controllerTch2.text.isNotEmpty
          ? double.parse(controllerTch2.text)
          : null,
      tch3: controllerTch3.text.isNotEmpty
          ? double.parse(controllerTch3.text)
          : null,
      tch4: controllerTch4.text.isNotEmpty
          ? double.parse(controllerTch4.text)
          : null);
}
