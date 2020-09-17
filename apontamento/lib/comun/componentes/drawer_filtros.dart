import 'package:apontamento/comun/componentes/date_field.dart';
import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

class DrawerFiltros extends StatelessWidget {
  final bool estimativa;
  final List<String> listaSafra;
  final List<String> listaUp1;
  final List<String> listaUp2;
  final List<String> listaUp3;
  final Map<String, String> filtros;
  final Function(String chave, String valor) alteraFiltro;
  final Function(Map<String, String> filtros) filtrar;
  final Map<String, String> listaStatus = {
    'Selecione': '',
    'Sincronizado': '(\'I\')',
    'Pendente': '(\'P\',\'E\')',
  };

  DrawerFiltros({
    @required this.filtros,
    @required this.alteraFiltro,
    @required this.filtrar,
    @required this.listaSafra,
    @required this.listaUp1,
    @required this.listaUp2,
    @required this.listaUp3,
    this.estimativa = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              estimativa
                  ? TextFormField(
                      initialValue: filtros['noBoletim'] ?? '',
                      decoration: InputDecoration(labelText: 'Boletim'),
                      keyboardType: TextInputType.number,
                      onChanged: (valor) => alteraFiltro('noBoletim', valor),
                    )
                  : Container(),
              DateField(
                callback: (DateTime valor) => alteraFiltro(
                  'dtHistoricoInicio',
                  Moment.fromDate(valor).format('yyyy-MM-dd'),
                ),
                label: 'Data Inicial',
                selectedDate: filtros['dtHistoricoInicio'] != null
                    ? DateTime.parse(filtros['dtHistoricoInicio'])
                    : null,
              ),
              DateField(
                callback: (DateTime valor) => alteraFiltro(
                  'dtHistoricoFim',
                  Moment.fromDate(valor).format('yyyy-MM-dd'),
                ),
                label: 'Data Final',
                selectedDate: filtros['dtHistoricoFim'] != null
                    ? DateTime.parse(filtros['dtHistoricoFim'])
                    : null,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Safra'),
                items: listaSafra
                    .map((String item) => DropdownMenuItem<String>(
                          value: item ?? '',
                          child: Text(item.isEmpty
                              ? 'Selecione'
                              : item.replaceAll(' ', '0')),
                        ))
                    .toList(),
                onChanged: (String valor) => alteraFiltro('cdSafra', valor),
                value: filtros['cdSafra'],
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Upnivel1'),
                items: listaUp1
                    .map((String item) => DropdownMenuItem<String>(
                          value: item ?? '',
                          child: Text(item.isEmpty
                              ? 'Selecione'
                              : item.replaceAll(' ', '0')),
                        ))
                    .toList(),
                onChanged: (String valor) => alteraFiltro('cdUpnivel1', valor),
                value: filtros['cdUpnivel1'],
              ),
              DropdownButtonFormField<String>(
                items: listaUp2
                    .map((String item) => DropdownMenuItem<String>(
                          value: item ?? '',
                          child: Text(item.isEmpty
                              ? 'Selecione'
                              : item.replaceAll(' ', '0')),
                        ))
                    .toList(),
                decoration: InputDecoration(labelText: 'Upnivel2'),
                onChanged: (String valor) => alteraFiltro('cdUpnivel2', valor),
                value: filtros['cdUpnivel2'],
              ),
              DropdownButtonFormField<String>(
                items: listaUp3
                    .map((String item) => DropdownMenuItem<String>(
                          value: item ?? '',
                          child: Text(item.isEmpty
                              ? 'Selecione'
                              : item.replaceAll(' ', '0')),
                        ))
                    .toList(),
                decoration: InputDecoration(labelText: 'Upnivel3'),
                onChanged: (String valor) => alteraFiltro('cdUpnivel3', valor),
                value: filtros['cdUpnivel3'],
              ),
              estimativa
                  ? DropdownButtonFormField<String>(
                      items: listaStatus.keys
                          .map((String chave) => DropdownMenuItem<String>(
                                value: listaStatus[chave] ?? '',
                                child: Text(chave),
                              ))
                          .toList(),
                      decoration: InputDecoration(labelText: 'Status'),
                      onChanged: (String valor) =>
                          alteraFiltro('status', valor),
                      value: filtros['status'],
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.only(top: 16),
                height: 56,
                child: OutlineButton.icon(
                  icon: Icon(Icons.filter_list),
                  label: Text('Filtrar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    filtrar(filtros);
                  },
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
