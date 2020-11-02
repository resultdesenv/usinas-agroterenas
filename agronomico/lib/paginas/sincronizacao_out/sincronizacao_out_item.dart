import 'package:agronomico/comum/modelo/sincronizacao_out_model.dart';
import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

class SincronizacaoOutItem extends StatelessWidget {
  final SincronizacaoOutModel item;
  final Function sincronizar;
  final bool carregando;

  SincronizacaoOutItem({
    @required this.item,
    @required this.sincronizar,
    @required this.carregando,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.titulo,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pendentes ${item.naoSincronizados.toString()}'
            '${item.naoSincronizadosOutras ? ' | tem pendentes nas outras instancias' : ''}',
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              item.dataUltimaSincronizacao != null
                  ? 'Sincronizado em ${Moment.parse(item.dataUltimaSincronizacao).format('dd/MM/yyyy')}'
                      ' por ${item.duracaoSincronizacao}'
                  : 'Sem histórico de sincronização',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
      isThreeLine: true,
      trailing: Align(
        widthFactor: 1,
        alignment: Alignment.center,
        child: carregando
            ? Container(
                height: 28,
                width: 28,
                child: Center(child: CircularProgressIndicator()),
              )
            : Icon(Icons.refresh, size: 28),
      ),
      onTap: () {
        if (!carregando) sincronizar();
      },
    );
  }
}
