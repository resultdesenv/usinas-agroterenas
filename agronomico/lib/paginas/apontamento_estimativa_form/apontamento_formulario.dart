import 'package:agronomico/comum/modelo/estimativa_modelo.dart';
import 'package:agronomico/comum/modelo/upnivel3_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_moment/simple_moment.dart';

class ApontamentoFormulario extends StatelessWidget {
  final EstimativaModelo apontamento;
  final UpNivel3Model upNivel3;
  final TextEditingController controllerTch0;
  final TextEditingController controllerTch1;
  final TextEditingController controllerTch2;
  final TextEditingController controllerTch3;
  final TextEditingController controllerTch4;
  final Function({
    @required String tch0,
    @required String tch1,
    @required String tch2,
    @required String tch3,
    @required String tch4,
  }) replicar;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ApontamentoFormulario({
    @required this.apontamento,
    @required this.controllerTch0,
    @required this.controllerTch1,
    @required this.controllerTch2,
    @required this.controllerTch3,
    @required this.controllerTch4,
    @required this.replicar,
    this.upNivel3,
  });

  bool validar() => formKey.currentState.validate();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 24),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
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
                          initialValue: apontamento.cdUpnivel1,
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
                          initialValue: apontamento.cdUpnivel2,
                          enabled: false,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 16)),
                      Expanded(
                        child: _montaCampo(
                          labelText: 'UpNivel3',
                          initialValue: apontamento.cdUpnivel3,
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: ExpansionTile(
                title: Text('Detalhes'),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
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
                                labelText: 'Ult.Compra',
                                initialValue:
                                    Moment.parse(apontamento.dtUltimoCorte)
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
                  )
                ],
              ),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(color: Colors.black12, width: 1),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _montaCampo(
                          validator: _validarCampo,
                          enabled: upNivel3 == null ||
                              upNivel3.tch0 == null ||
                              upNivel3.tch0 <= 0,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          labelText: 'Tch0',
                          controller: controllerTch0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 16)),
                      Expanded(
                        child: _montaCampo(
                          validator: _validarCampo,
                          enabled: upNivel3 == null ||
                              upNivel3.tch1 == null ||
                              upNivel3.tch1 <= 0,
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
                          validator: _validarCampo,
                          enabled: upNivel3 == null ||
                              upNivel3.tch2 == null ||
                              upNivel3.tch2 <= 0,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          labelText: 'Tch2',
                          controller: controllerTch2,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 16)),
                      Expanded(
                        child: _montaCampo(
                          validator: _validarCampo,
                          enabled: upNivel3 == null ||
                              upNivel3.tch3 == null ||
                              upNivel3.tch3 <= 0,
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
                          validator: _validarCampo,
                          enabled: upNivel3 == null ||
                              upNivel3.tch4 == null ||
                              upNivel3.tch4 <= 0,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          labelText: 'Tch4',
                          controller: controllerTch4,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 16)),
                      Expanded(
                        child: RaisedButton(
                          child: Text(
                            'Replicar',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () => _confimaReplica(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confimaReplica(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Você tem certeza?'),
        content:
            Text('Deseja replicar para TODAS as estimativas selecionadas?'),
        actions: [
          FlatButton(
            child: Text('Voltar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text(
              'Continuar',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              this.replicar(
                tch0: controllerTch0.text.isEmpty ? '0' : controllerTch0.text,
                tch1: controllerTch1.text.isEmpty ? '0' : controllerTch1.text,
                tch2: controllerTch2.text.isEmpty ? '0' : controllerTch2.text,
                tch3: controllerTch3.text.isEmpty ? '0' : controllerTch3.text,
                tch4: controllerTch4.text.isEmpty ? '0' : controllerTch4.text,
              );
            },
          ),
        ],
      ),
    );
  }

  TextFormField _montaCampo({
    @required String labelText,
    dynamic initialValue,
    TextEditingController controller,
    bool enabled = false,
    Function(String) onChange,
    TextInputType keyboardType,
    String Function(String) validator,
  }) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(labelText: labelText),
      style: TextStyle(color: enabled ? Colors.black : Colors.grey),
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

  String _validarCampo(String value) {
    return value == null || value.isEmpty || double.parse(value) == 0
        ? 'Preencha este campo!'
        : null;
  }
}
