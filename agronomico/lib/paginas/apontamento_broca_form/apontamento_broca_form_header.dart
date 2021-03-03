import 'package:agronomico/comum/componentes/date_field.dart';
import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:agronomico/comum/modelo/tipo_fitossanidade_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ApontamentoBrocaFormHeader extends StatelessWidget {
  final Function(int) onChanged;
  final ApontBrocaModel broca;
  final List<TipoFitossanidadeModel> tiposFitossanidade;
  final bool novoApontamento;
  final int canas;
  final Function(String) alterarQuantidade;
  final Function(DateTime) alterarData;
  final TextEditingController controller;

  ApontamentoBrocaFormHeader({
    @required this.onChanged,
    @required this.broca,
    @required this.tiposFitossanidade,
    @required this.novoApontamento,
    @required this.canas,
    @required this.alterarQuantidade,
    @required this.alterarData,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _montaCampo('Boletim', broca.noBoletim.toString()),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _montaCampo('Safra', broca.cdSafra.toString()),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _montaCampo('No Coletor', broca.noColetor.toString()),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _montaCampo('Fazenda', broca.cdUpnivel1.toString()),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _montaCampo('Zona', broca.cdUpnivel2.toString()),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _montaCampo('Talhão', broca.cdUpnivel3.toString()),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Fitossanidade',
                    ),
                    value: broca.cdFitoss,
                    items: tiposFitossanidade
                        .map((tipo) => DropdownMenuItem(
                              child: Text(tipo.deFitoss),
                              value: tipo.cdFitoss,
                            ))
                        .toList(),
                    onChanged: onChanged,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: DateField(
                      callback: alterarData,
                      label: 'Data',
                      selectedDate: DateTime.parse(broca.dtOperacao),
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Canas'),
              controller: controller,
              keyboardType: TextInputType.number,
              enabled: novoApontamento,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'\d'))
              ],
              onFieldSubmitted: alterarQuantidade,
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _montaCampo(String label, String valor) => TextFormField(
        decoration: InputDecoration(
          labelText: label,
        ),
        style: TextStyle(color: Colors.grey),
        initialValue: valor,
        enabled: false,
      );
}
