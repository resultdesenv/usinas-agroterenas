import 'package:apontamento/comun/modelo/dispositivo_model.dart';
import 'package:flutter/material.dart';

class ConfiguracaoDispositivo extends StatelessWidget {
  final DispositivoModel dispositivo;

  ConfiguracaoDispositivo({@required this.dispositivo});

  @override
  Widget build(BuildContext context) {
    return dispositivo != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1)),
                child: Column(children: [
                  ListTile(
                      title: Text('Dispositivo',
                          style: TextStyle(fontWeight: FontWeight.w500))),
                  ListTile(
                      title:
                          Text('ID Dispositivo: ${dispositivo.idDispositivo}'),
                      subtitle: Text('Imei: ${dispositivo.imei}'),
                      isThreeLine: true,
                      trailing: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                              color: dispositivo.situacao == 'A'
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(16))))
                ])))
        : Container();
  }
}
