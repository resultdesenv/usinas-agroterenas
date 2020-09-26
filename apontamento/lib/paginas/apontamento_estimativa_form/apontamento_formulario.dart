import 'package:apontamento/comum/modelo/estimativa_modelo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

class ApontamentoFormulario extends StatelessWidget {
  final EstimativaModelo apontamento;
  final Function(EstimativaModelo) onChanged;

  ApontamentoFormulario({@required this.apontamento, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
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
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Divider(),
              ),
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Tech0',
                      initialValue: apontamento.tch0,
                      keyboardType: TextInputType.number,
                      onChanged: (valor) {
                        onChanged(
                            apontamento.copiarCom(tch0: int.parse(valor)));
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Tech1',
                      initialValue: apontamento.tch1,
                      keyboardType: TextInputType.number,
                      onChanged: (valor) {
                        onChanged(
                            apontamento.copiarCom(tch1: int.parse(valor)));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Tech2',
                      initialValue: apontamento.tch2,
                      keyboardType: TextInputType.number,
                      onChanged: (valor) {
                        onChanged(
                            apontamento.copiarCom(tch2: int.parse(valor)));
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Tech3',
                      initialValue: apontamento.tch3,
                      keyboardType: TextInputType.number,
                      onChanged: (valor) {
                        onChanged(
                            apontamento.copiarCom(tch3: int.parse(valor)));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _montaCampo(
                      labelText: 'Tech4',
                      initialValue: apontamento.tch4,
                      keyboardType: TextInputType.number,
                      onChanged: (valor) {
                        onChanged(
                            apontamento.copiarCom(tch4: int.parse(valor)));
                      },
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
              _montaCampo(
                labelText: 'TpProp',
                initialValue: apontamento.cdTpPropr,
                enabled: false,
              ),
              _montaCampo(
                labelText: 'Estagio',
                initialValue: apontamento.cdEstagio,
                enabled: false,
              ),
              _montaCampo(
                labelText: 'Variedade',
                initialValue: apontamento.cdVaried,
                enabled: false,
              ),
              _montaCampo(
                labelText: 'Ult. Compra',
                initialValue: Moment.parse(apontamento.dtUltimoCorte)
                    .format('dd/MM/yyyy'),
                enabled: false,
              ),
              _montaCampo(
                labelText: 'Precip',
                initialValue: apontamento.precipitacao,
                enabled: false,
              ),
              _montaCampo(
                labelText: 'Área Prod',
                initialValue: apontamento.qtAreaProd,
                enabled: false,
              ),
              _montaCampo(
                labelText: 'Prod Ant',
                initialValue: apontamento.producaoSafraAnt,
                enabled: false,
              ),
              _montaCampo(
                labelText: 'Sphenoph',
                initialValue: apontamento.sphenophous,
                enabled: false,
              ),
              _montaCampo(
                labelText: 'Tch Ant',
                initialValue: apontamento.tch0,
                enabled: false,
              ),
              _montaCampo(
                labelText: 'Tch Retro',
                enabled: false,
                initialValue: apontamento.tch0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _montaCampo(
      {@required String labelText,
      @required dynamic initialValue,
      bool enabled = true,
      Function(String) onChanged,
      TextInputType keyboardType}) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      initialValue: initialValue != null ? initialValue.toString() : null,
      enabled: enabled,
      onChanged: onChanged,
      keyboardType: keyboardType,
    );
  }
}
