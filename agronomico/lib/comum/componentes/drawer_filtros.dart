import 'package:agronomico/comum/componentes/date_field.dart';
import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

class DrawerFiltros extends StatelessWidget {
  final TextEditingController controllerBoletim;
  final TextEditingController controllerZona;
  final bool apontamento;
  final Map<String, dynamic> filtros;
  final Function(String chave, String valor) alteraFiltro;
  final Function(Map<String, dynamic> filtros) filtrar;
  final Map<String, String> listaStatus = {
    'Selecione': '',
    'Sincronizado': '(\'I\')',
    'Pendente': '(\'P\',\'E\')',
  };
  final bool filtrarData;

  DrawerFiltros({
    @required this.filtros,
    @required this.alteraFiltro,
    @required this.filtrar,
    @required this.controllerZona,
    this.apontamento = false,
    this.filtrarData = true,
    this.controllerBoletim,
  });

  @override
  Widget build(BuildContext context) {
    if (filtrarData && filtros['dtInicio'] == null)
      alteraFiltro('dtInicio', Moment.now().format('yyyy-MM-dd'));
    if (filtrarData && filtros['dtFim'] == null)
      alteraFiltro('dtFim', Moment.now().format('yyyy-MM-dd'));

    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              apontamento
                  ? TextFormField(
                      decoration: InputDecoration(labelText: 'Boletim'),
                      keyboardType: TextInputType.number,
                      controller: controllerBoletim,
                    )
                  : Container(),
              Row(
                children: filtrarData
                    ? [
                        Expanded(
                          child: DateField(
                            callback: (DateTime valor) => alteraFiltro(
                              'dtInicio',
                              Moment.fromDate(valor).format('yyyy-MM-dd'),
                            ),
                            label: 'Data Inicial',
                            selectedDate: filtros['dtInicio'] != null
                                ? DateTime.parse(filtros['dtInicio'])
                                : DateTime.now(),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                          width: 32,
                          child: IconButton(
                            padding: EdgeInsets.all(2),
                            tooltip: 'Limpar data inicial',
                            icon: Icon(Icons.close),
                            onPressed: () => alteraFiltro('dtInicio', ''),
                            color: Colors.red,
                          ),
                        ),
                      ]
                    : [],
              ),
              Row(
                children: filtrarData
                    ? [
                        Expanded(
                          child: DateField(
                            callback: (DateTime valor) => alteraFiltro(
                              'dtFim',
                              Moment.fromDate(valor).format('yyyy-MM-dd'),
                            ),
                            label: 'Data Final',
                            selectedDate: filtros['dtFim'] != null
                                ? DateTime.parse(filtros['dtFim'])
                                : DateTime.now(),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                          width: 32,
                          child: IconButton(
                            padding: EdgeInsets.all(2),
                            tooltip: 'Limpar data final',
                            icon: Icon(Icons.close),
                            onPressed: () => alteraFiltro('dtFim', ''),
                            color: Colors.red,
                          ),
                        ),
                      ]
                    : [],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Zona'),
                keyboardType: TextInputType.number,
                controller: controllerZona,
              ),
              apontamento
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
                  icon: Icon(Icons.close),
                  label: Text('Limpar Filtros'),
                  onPressed: () {
                    if (apontamento) {
                      controllerBoletim.text = '';
                      controllerZona.text = '';
                      alteraFiltro('status', '');
                    }
                    alteraFiltro('noBoletim', '');
                    alteraFiltro('dtInicio', '');
                    alteraFiltro('dtFim', '');
                    alteraFiltro('cdSafra', '');
                    alteraFiltro('cdUpnivel2', '');
                    alteraFiltro('status', '');
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                height: 56,
                child: OutlineButton.icon(
                  icon: Icon(Icons.filter_list),
                  label: Text('Filtrar'),
                  onPressed: () {
                    if (apontamento) {
                      alteraFiltro('noBoletim', controllerBoletim.text);
                    }
                    alteraFiltro('cdUpnivel2', controllerZona.text);

                    Navigator.of(context).pop();
                    filtrar({
                      ...filtros,
                      'noBoletim': apontamento ? controllerBoletim.text : '',
                      'cdUpnivel2': controllerZona.text,
                    });
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
