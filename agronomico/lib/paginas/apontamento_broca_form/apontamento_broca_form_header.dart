import 'package:agronomico/comum/modelo/apont_broca_model.dart';
import 'package:agronomico/comum/modelo/tipo_fitossanidade_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ApontamentoBrocaFormHeader extends StatelessWidget {
  final Function(int) onChanged;
  final ApontBrocaModel broca;
  final List<TipoFitossanidadeModel> tiposFItossanidade;

  ApontamentoBrocaFormHeader({
    @required this.onChanged,
    @required this.broca,
    @required this.tiposFItossanidade,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
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
                  child: _montaCampo('Upnivel 1', broca.cdUpnivel1.toString()),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _montaCampo('Upnivel 2', broca.cdUpnivel2.toString()),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _montaCampo('Upnivel 3', broca.cdUpnivel3.toString()),
                ),
              ],
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Tipo de Broca',
              ),
              value: broca.cdFitoss,
              items: tiposFItossanidade
                  .map((tipo) => DropdownMenuItem(
                        child: Text(tipo.deFitoss),
                        value: tipo.cdFitoss,
                      ))
                  .toList(),
              onChanged: onChanged,
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
